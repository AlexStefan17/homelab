pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                sh '''
                    cd /var/lib/jenkins/workspace/k3s-ansible/homelab
                    git reset --hard
                    git pull
                '''
            }
        }

        stage('Run Ansible') {
            steps {
                withCredentials([string(credentialsId: '90bf0e25-8b98-4276-aa6f-2355ce50bbd5', variable: 'VAULT_PASS')]) {
                    sh """
                        sudo -u alex bash -c '
                            cd /var/lib/jenkins/workspace/k3s-ansible/homelab/ansible &&
                            echo "$VAULT_PASS" | ansible-playbook playbooks/site.yaml --ask-vault-pass
                        '
                    """
                }
            }
        }

    }
}

