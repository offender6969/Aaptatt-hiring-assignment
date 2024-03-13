pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "iamdivye/maven-cicd:${BUILD_NUMBER}"
        DOCKER_REPO = "iamdivye/maven-cicd"
        DOCKER_TAG = "latest"
        EC2_USERNAME = 'ubuntu'
        EC2_HOST = '3.82.207.251'
        EC2_KEY_PATH = '/home/offender/jenkins_slave.pem' // Updated key path
        WAR_FILE = 'Aaptatt-hiring-assignment/target/*.war'
        DOCKERFILE_PATH = 'Dockerfile' // Dockerfile in the root directory
        CONTAINER_NAME = 'maven_prod'
        HOST_PORT = '8080'
        CONTAINER_PORT = '8080'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/offender6969/Aaptatt-hiring-assignment'
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
                    docker.build("${DOCKER_IMAGE}", "-t ${DOCKER_REPO}:${DOCKER_TAG} -f ${DOCKERFILE_PATH} .")
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-cred') {
                        docker.image("${DOCKER_IMAGE}").push("${DOCKER_TAG}")
                    }
                }
            }
        }

        stage('Run Docker Container on Remote EC2 Instance') {
            steps {
                script {
                    sshagent(['github']) {
                        sh "scp -i ${EC2_KEY_PATH} -o StrictHostKeyChecking=no ${DOCKERFILE_PATH} ${EC2_USERNAME}@${EC2_HOST}:~/"
                        sh "scp -i ${EC2_KEY_PATH} -o StrictHostKeyChecking=no /var/jenkins_home/workspace/${JOB_NAME}/docker_data/${DOCKER_IMAGE}.tar ${EC2_USERNAME}@${EC2_HOST}:~/"
                        sh "ssh -i ${EC2_KEY_PATH} -o StrictHostKeyChecking=no ${EC2_USERNAME}@${EC2_HOST} 'docker load -i ~/${DOCKER_IMAGE}.tar'"
                        sh "ssh -i ${EC2_KEY_PATH} -o StrictHostKeyChecking=no ${EC2_USERNAME}@${EC2_HOST} 'docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}'"
                    }
                }
            }
        }
    }
}
