pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Perform clean install to build and install the project
                sh 'mvn clean install'
            }
        }
        stage('Test') {
            steps {
                // Run unit tests
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                // Simulating deployment step (you can add actual deployment steps here)
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
