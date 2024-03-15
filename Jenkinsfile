pipeline {
    agent any

    environment {
        WAR_FILE = 'Aaptatt-hiring-assignment/target/*.war'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/offender6969/Aaptatt-hiring-assignment'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'mvn clean package -f Aaptatt-hiring-assignment'
            }
        }
    }
}
