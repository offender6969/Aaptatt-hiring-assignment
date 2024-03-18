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
                    docker.build("${DOCKER_IMAGE}", "-f Dockerfile .")
                }
            }
        }

        stage('Log in to Docker Hub') {
            steps {
                script {
                    // 
                    withCredentials([string(credentialsId: DOCKER_HUB_CREDENTIALS, variable: 'DOCKER_HUB_CREDENTIALS')]) {
                        sh 'echo $DOCKER_HUB_CREDENTIALS | docker login -u <your-dockerhub-username> --password-stdin'
                    }

                    // Push the Docker image with "latest" tag to Docker Hub
                    sh "docker push ${DOCKER_IMAGE}:latest" // Corrected variable interpolation syntax
                }
            }
        }
    }
}
