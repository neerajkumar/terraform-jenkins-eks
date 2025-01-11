pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_SECRET_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "ap-south-1"
    }
    stages {
        stage("Checkout SCM") {
            steps {
                script {
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/neerajkumar/terraform-jenkins-eks.git']])
                }
            }
        }
        stage("Initializing Terraform") {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage("Formatting Terraform") {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform fmt'
                    }
                }
            }
        }
        stage("Validating Terraform") {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage("Previewing the Infra using Terraform") {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", OK: "Proceed")
                }
            }
        }
        stage("Creating/Destroying an EKS Cluster") {
            steps {
                script {
                    dir('EKS') {
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        stage('Deploying Nginx Application') {
            steps{
                script{
                    dir('EKS/ConfigurationFiles') {
                        sh 'aws eks update-kubeconfig --name my-eks-cluster'
                        sh 'kubectl apply -f deployment.yml'
                        sh 'kubectl apply -f service.yaml'
                    }
                }
            }
        }
    }
}
