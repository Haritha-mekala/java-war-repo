pipeline {
    agent { label 'Docker' }

    environment {
        AWS_REGION = 'us-east-1' // Change as per requirement
        ECR_REPO = '650251727509.dkr.ecr.us-east-1.amazonaws.com/ecr_docker'
        
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Haritha-mekala/java-war-repo.git'
            }
        }

        stage('Build Java Application') {
            steps {
                sh 'mvn clean package -DskipTests' // Ensure Maven is installed on the agent
            }
        }
         stage('Test') {
            steps {
                sh 'pwd'
                sh 'sudo docker ps'
                sh 'curl ifconfig.me'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ecr_docker .'
            }
        }

        stage('Push Image to AWS ECR') {
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 650251727509.dkr.ecr.us-east-1.amazonaws.com
                    sudo docker tag ecr_docker:latest 650251727509.dkr.ecr.us-east-1.amazonaws.com/ecr_docker:latest
                    sudo docker push 650251727509.dkr.ecr.us-east-1.amazonaws.com/ecr_docker:latest
                    '''
                }
            }
        }
    }
}
