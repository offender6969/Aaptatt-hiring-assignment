pipeline {
    agent {
        docker {
            image 'abhishekf5/maven-abhishek-docker-agent:v1'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKER_IMAGE = "iamdivye/maven-cicd"
        EC2_USERNAME = 'ubuntu'
        EC2_HOST = '34.229.49.179'
        EC2_KEY_PATH = '/home/offender/jenkins_slave.pem'
        WAR_FILE = 'Aaptatt-hiring-assignment/target/*.war'
        CONTAINER_NAME = 'maven1'
        HOST_PORT = '8081'
        CONTAINER_PORT = '8080'
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

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'git') {                   
                        app.push("${env.BUILD_NUMBER}")            
                        app.push("latest")        
                    }    
                }
            }
        }
    }
}
