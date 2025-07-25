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
        stage('AMI Create with Packer') {
            when {
                expression { params.BUILD_AMI == 'yes' }
            }
            steps {
                echo ' Running Packer to build AMI...'
                sh '''
                    packer validate --var-file packer-vars.json ${PACKER_TEMPLATE}
                    packer build --var-file packer-vars.json ${PACKER_TEMPLATE} | tee packer_output.log

                    grep -oE 'ami-[a-z0-9]+' packer_output.log | tail -1 | \
                    awk '{print "ami = \\"" $1 "\\""}' > ami.tfvars

                    echo " AMI ID saved to ami.tfvars"
                    cat ami.tfvars
                '''
            }
        }
    }
}
