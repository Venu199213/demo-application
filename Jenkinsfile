pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9'  // Ensure the correct Maven tool version is configured in Jenkins
    }
    environment {
        DOCKER_IMAGE = "venuanna/demo-application"  // Your Docker Hub repository
        DOCKER_TAG = "${env.BUILD_NUMBER}"          // Unique tag for each build
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Checkout code from SCM (like Git)
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean install'  // Build the WAR file using Maven
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'  // Run tests
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the build number as the tag
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub and push the image
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        dockerImage.push("${DOCKER_TAG}")  // Push the image with the build number tag
                        dockerImage.push("latest")         // Also push a "latest" tag
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
