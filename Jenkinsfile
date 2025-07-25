pipeline {
    agent {
        label 'Dev'
    }
    parameters {
        choice(name: 'BUILD_AMI', choices: ['yes', 'no'], description: 'Do you want to build an AMI using Packer?')
        choice(name: 'TERRAFORM_ACTION', choices: ['apply', 'destroy'], description: 'Choose Terraform action to perform')
    }
    environment {
        PACKER_TEMPLATE = 'packer.json'
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
                    packer plugins install github.com/hashicorp/amazon
                    packer validate --var-file packer-vars.json ${PACKER_TEMPLATE}
                    packer build --var-file packer-vars.json ${PACKER_TEMPLATE} | tee packer_output.log

                    grep -oE 'ami-[a-z0-9]+' packer_output.log | tail -1 | \
                    awk '{print "ami = \\"" $1 "\\""}' > ami.tfvars

                    echo " AMI ID saved to ami.tfvars"
                    cat ami.tfvars
                '''
            }
        }
                stage('Fetch Existing AMI') {
            when {
                expression { params.BUILD_AMI == 'no' }
            }
            steps {
                echo '🔍 Fetching latest AMI by name from AWS EC2...'
                sh '''
                    ami_id=$(aws ec2 describe-images \
                        --owners self \
                        --region ${REGION} \
                        --filters "Name=name,Values=${AMI_NAME_PREFIX}*" "Name=state,Values=available" \
                        --query 'Images | sort_by(@, &CreationDate) | [-1].ImageId' \
                        --output text)

                    echo "ami = \\"$ami_id\\"" > ami.tfvars

                    echo " AMI ID from AWS: $ami_id"
                    cat ami.tfvars
                '''
            }
        }

         stage('Terraform Apply') {
            when {
                expression { params.TERRAFORM_ACTION == 'apply' }
            }
            steps {
                echo ' Running Terraform Apply...'
                sh '''
                    terraform init
                    terraform plan --var-file=ami.tfvars
                    terraform apply --auto-approve --var-file=ami.tfvars
                '''
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.TERRAFORM_ACTION == 'destroy' }
            }
            steps {
                echo '🧹 Destroying Terraform Infrastructure...'
                sh '''
                    terraform destroy --auto-approve --var-file=ami.tfvars
                '''
            }
        }
    }
}
