pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="336654342245"
        AWS_DEFAULT_REGION="us-east-1" 
        IMAGE_REPO_NAME="jenkins-docker"
        IMAGE_TAG="latest"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
   
    stages {
        
        stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }

        stage('Git Checkout') {
            steps {
                cleanWs()
                sh '''
                git clone https://github.com/soumyanild/Docker.git
                '''
            }
        }
  
    // Building Docker images
        stage('Building image') {
          steps{
            script {
                sh "docker build -t ${IMAGE_REPO_NAME}:${IMAGE_TAG} . -f Docker/Dockerfile"
            }
          }
        }
   
    // Uploading Docker images into AWS ECR
        stage('Pushing to ECR') { 
          steps{  
            script {
                sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
            }  
        }
      }
    } 
}
