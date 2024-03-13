pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Build the Maven application
                sh 'mvn clean package -DskipTests'
                sh 'mv $(find ./target -name "*.war") ./target/app.war'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                // Build Docker image
                script {
                    docker.build('your-docker-image-name')
                }
            }
        }
        
        stage('Tag Docker Image') {
            steps {
                // Tag the Docker image
                script {
                    docker.image('your-docker-image-name').tag("your-docker-image-name:latest")
                }
            }
        }
        
        stage('Push Docker Image to Docker Hub') {
            environment {
                DOCKER_HUB_CREDENTIALS = 'your-docker-hub-credentials-id'
            }
            steps {
                // Push the Docker image to Docker Hub
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        docker.image('your-docker-image-name').push('latest')
                    }
                }
            }
        }
    }
}
