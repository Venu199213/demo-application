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
                    bat """
                        if exist ${CONTAINER_NAME} (
                            docker rm -f ${CONTAINER_NAME}
                        )
                    """
                    
                    // Run the Docker container
                    bat """
                        docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            // Stop and remove the container here
            bat "docker stop ${CONTAINER_NAME} || exit 0"
            bat "docker rm ${CONTAINER_NAME} || exit 0"
        }
        success {
            echo 'Build and Docker image creation succeeded!'
        }
        failure {
            echo 'Build or Docker image creation failed!'
        }
    }
}
