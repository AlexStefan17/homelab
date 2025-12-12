pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['test', 'prod'],
            description: 'Choose environment to deploy (test or prod)'
        )
        string(
            name: 'GIT_BRANCH',
            defaultValue: 'main',
            description: 'Git branch to use when cloning manifests'
        )
    }

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

                    script {
                        def ansibleCommand = ""

                        if (params.ENVIRONMENT == "prod") {

                            ansibleCommand = """
                                ansible-playbook \
                                    playbooks/site.yaml \
                                    --ask-vault-pass \
                                    -e git_branch=${params.GIT_BRANCH}
                            """

                        } else {

                            ansibleCommand = """
                                ansible-playbook \
                                    -i inventory/inventory-test.yaml \
                                    playbooks/site-test.yaml \
                                    --ask-vault-pass \
                                    -e git_branch=${params.GIT_BRANCH}
                            """ww
                        }

                        sh """
                            sudo -u alex bash -c '
                                cd /var/lib/jenkins/workspace/k3s-ansible/homelab/ansible &&
                                echo "$VAULT_PASS" | ${ansibleCommand}
                            '
                        """
                    }
                }
            }
        }

    }
}
