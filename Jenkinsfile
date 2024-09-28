pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9'
    }
    environment {
        DOCKER_IMAGE = "venuanna/demo-application" 
        DOCKER_TAG = "latest"
        CONTAINER_NAME = "demo-application-container"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Checkout code from SCM (like Git)
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean install' 
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        dockerImage.push("${DOCKER_TAG}")
                    }
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    // Remove the container if it exists
                    sh """
                        if [ \$(docker ps -aq -f name=${CONTAINER_NAME}) ]; then
                            docker rm -f ${CONTAINER_NAME}
                        fi
                    """
                    
                    // Run the Docker container
                    sh """
                        docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            // Optionally, you can stop and remove the container here
            sh "docker stop ${CONTAINER_NAME} || true"
            sh "docker rm ${CONTAINER_NAME} || true"
        }
        success {
            echo 'Build and Docker image creation succeeded!'
        }
        failure {
            echo 'Build or Docker image creation failed!'
        }
    }
    
}
