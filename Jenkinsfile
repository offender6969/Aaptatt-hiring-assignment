pipeline {
  agent any
  
  environment {
    DOCKER_IMAGE = "iamdivye/maven-cicd:${BUILD_NUMBER}"
    EC2_USERNAME = 'ec2-user'
    EC2_HOST = 'your_remote_ec2_host'
    EC2_KEY_PATH = ' /home/offender/jenkins_slave.pem'
    WAR_FILE = 'Aaptatt-hiring-assignment/target/*.war'
    DOCKERFILE_PATH = 'Aaptatt-hiring-assignment/Dockerfile'
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
          docker.build("${DOCKER_IMAGE}", "-f ${DOCKERFILE_PATH} .")
        }
      }
    }

    stage('Run Docker Container on Remote EC2 Instance') {
      steps {
        script {
          sshagent(['github']) {
            sh "scp -i ${EC2_KEY_PATH} -o StrictHostKeyChecking=no /var/jenkins_home/workspace/${JOB_NAME}/${DOCKERFILE_PATH} ${EC2_USERNAME}@${EC2_HOST}:~/"
            sh "scp -i ${EC2_KEY_PATH} -o StrictHostKeyChecking=no /var/jenkins_home/workspace/${JOB_NAME}/docker_data/${DOCKER_IMAGE}.tar ${EC2_USERNAME}@${EC2_HOST}:~/"
            sh "ssh -i ${EC2_KEY_PATH} -o StrictHostKeyChecking=no ${EC2_USERNAME}@${EC2_HOST} 'docker load -i ~/${DOCKER_IMAGE}.tar'"
            sh "ssh -i ${EC2_KEY_PATH} -o StrictHostKeyChecking=no ${EC2_USERNAME}@${EC2_HOST} 'docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}'"
          }
        }
      }
    }
  }
}
