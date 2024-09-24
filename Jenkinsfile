pipeline {
    agent any
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
