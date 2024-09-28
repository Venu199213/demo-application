pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9'
    }
    environment {
        DOCKER_IMAGE = "venuanna/demo-application" 
        DOCKER_TAG = "latest"
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
