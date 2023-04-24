pipeline {
    agent any
    environment {
        PATH = "/usr/local/bin:$PATH"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/shubham-yadavv/ContainerFlow']]])
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t shubham22121/containerflow:v1 .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u shubham22121 -p ${dockerhubpwd}'
                }
                   sh 'docker push shubham22121/containerflow:v1'
                }
            }
        }

        // stage run docker container with compose
        stage('Run docker container with compose'){
            steps{
                script{
                    sh 'make deploy'
                }
            }
        }
    }
}