pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9'
    }
    environment {
        DOCKER_IMAGE = "demo-application"
        DOCKER_TAG = "${env.BUILD_NUMBER}" 
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm 
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
                    // Log in to Docker Hub and push the image
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        dockerImage.push("${DOCKER_TAG}")  // Push with the build number tag
                        dockerImage.push("latest")  // Also push a "latest" tag
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
        }
        success {
            echo 'Build and Docker image creation succeeded!'
        }
        failure {
            echo 'Build or Docker image creation failed!'
        }
    }
}
