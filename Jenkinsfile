pipeline {
    agent {
        docker {
            image 'abhishekf5/maven-abhishek-docker-agent:v1'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKER_IMAGE = 'iamdivye/maven-cicd'
        CONTAINER_NAME = 'maven1'
        HOST_PORT = '8081'
        CONTAINER_PORT = '8080'
        DOCKER_HUB_CREDENTIALS = 'docker-cred' 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'offender6969-patch-1', url: 'https://github.com/offender6969/Aaptatt-hiring-assignment'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image and tag it
                    docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}", "-f Dockerfile .")
                }
            }
        }

         stages {
        stage('Login to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                }
            }
        }
    }
}
}
