pipeline {
    agent any
    tools {
        maven 'Maven 3.9.9' // Specify the Maven version you configured in Jenkins
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean install' // Building the project
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test' // Running tests
            }
        }
        stage('Deploy') {
            steps {
                // Add deployment steps here
                echo 'Deploying application...'
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}



