pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['apply','destroy'], description: 'Create or destroy VM(s)')
        string(name: 'VM_LIST', defaultValue: '3,4', description: 'Comma-separated VM numbers (ex: 1,3,5)')
    }

    stages {
        stage('Checkout') {
            steps {
                dir('/var/lib/jenkins/workspace/terraform/terraform/homelab/terraform') {
                    sh '''
                        git reset --hard
                        git pull
                    '''
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'cd /var/lib/jenkins/workspace/terraform/terraform/homelab/terraform && terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Transformă "1,3,5" în ["vm1", "vm3", "vm5"]
                    def vms = params.VM_LIST
                        .split(",")
                        .collect { it.trim() }
                        .collect { "vm${it}" }

                    // Creează target-urile pentru Terraform
                    def targets = vms
                        .collect { "-target=module.vms[\\\"${it}\\\"].proxmox_vm_qemu.vm" }
                        .join(" ")

                    sh """
                        cd /var/lib/jenkins/workspace/terraform/terraform/homelab/terraform
                        terraform plan ${targets}
                    """
                }
            }
        }

        stage('Terraform Apply/Destroy') {
            steps {
                script {
                    def vms = params.VM_LIST
                        .split(",")
                        .collect { it.trim() }
                        .collect { "vm${it}" }

                    def targets = vms
                        .collect { "-target=module.vms[\\\"${it}\\\"].proxmox_vm_qemu.vm" }
                        .join(" ")

                    if (params.ACTION == "apply") {
                        sh """
                            cd /var/lib/jenkins/workspace/terraform/terraform/homelab/terraform
                            terraform apply -auto-approve ${targets}
                        """
                    } else {
                        sh """
                            cd /var/lib/jenkins/workspace/terraform/terraform/homelab/terraform
                            terraform destroy -auto-approve ${targets}
                        """
                    }
                }
            }
        }
    }
}

