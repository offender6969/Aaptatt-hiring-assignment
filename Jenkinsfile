pipeline {
    agent {
        docker {
            image 'abhishekf5/maven-abhishek-docker-agent:v1'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKER_IMAGE = "iamdivye/maven-cicd:${BUILD_NUMBER}"
        EC2_USERNAME = 'ubuntu'
        EC2_HOST = '3.82.207.251'
        EC2_KEY_PATH = '/home/offender/jenkins_slave.pem'
        WAR_FILE = 'Aaptatt-hiring-assignment/target/*.war'
        CONTAINER_NAME = 'maven_prod'
        HOST_PORT = '8080'
        CONTAINER_PORT = '8080'
    }

    stages {
        stage('Checkout') {
            steps {
               git branch: 'main', url: 'https://github.com/offender6969/Aaptatt-hiring-assignment'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'mvn clean package -f Aaptatt-hiring-assignment'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}", "-f Dockerfile .")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    docker.withRegistry('', 'docker-cred') {
                        sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Deploy WAR') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}").inside {
                        sh "docker cp /var/jenkins_home/workspace/${JOB_NAME}/${WAR_FILE} ${CONTAINER_NAME}:/usr/local/tomcat/webapps/ROOT.war"
                    }
                }
            }
        }
    }
}
