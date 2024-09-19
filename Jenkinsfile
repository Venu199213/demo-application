pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Example: Run a Maven build
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                // Example: Run unit tests
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                // Example: Deploy the WAR file
                echo 'Deploying application...'
            }
        }
    }
    post {
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}



