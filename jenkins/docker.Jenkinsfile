pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                dir('/var/lib/jenkins/workspace/docker-ansible/homelab') {
                    sh '''
                        git reset --hard
                        git pull
                    '''
                }
            }
        }

        stage('Run Ansible') {
            steps {
                script {
                    sh '''
                        sudo -u alex bash -c "
                            cd /var/lib/jenkins/workspace/docker-ansible/homelab/ansible
                            ansible-playbook playbooks/docker-install.yaml
                        "
                    '''
                }
            }
        }
    }
}

