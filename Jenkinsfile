pipeline {
    agent {
        label 'Dev'
    }
    parameters {
        choice(name: 'BUILD_AMI', choices: ['yes', 'no'], description: 'Do you want to build an AMI using Packer?')
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning git repository...'
                checkout scm
            }
        }
        stage('Check Packer Installation') {
            steps {
                script {
                    echo 'Checking if Packer is installed...'
                    def status = sh(script: 'which packer || echo "notfound"', returnStdout: true).trim()
                    if (status == 'notfound') {
                        error "Packer is not installed on the agent."
                    } else {
                        echo "Packer found at: ${status}"
                        sh 'packer --version'
                    }
                }
            }
        }
    }
}
