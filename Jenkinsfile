pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9'  // Use Maven version 3.9.9
    }
    environment {
        DOCKER_IMAGE = "demo-application"  // Name of the Docker image
        DOCKER_TAG = "${env.BUILD_NUMBER}"  // Tag based on the build number
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Check out the source code from the SCM
            }
        }
        stage('Build') {
            steps {
                script {
                    // Build the Java application using Maven
                    bat 'mvn clean install'
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    // Run tests on the application
                    bat 'mvn test'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                    echo "Docker image built: ${dockerImage.id}"  // Print the image ID to console
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
