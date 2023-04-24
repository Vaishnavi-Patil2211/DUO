pipeline {
    agent any
    environment {
        PATH = "/usr/local/bin:$PATH"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Vaishnavi-Patil2211/DUO']]])
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t vaishnavi2002/duo:v1 .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u vaishnavi2002 -p ${dockerhubpwd}'
                }
                   sh 'docker push vaishnavi2002/duo:v1'
                }
            }
        }

        // stage run docker container with compose
        stage('Run docker container with compose'){
            steps{
                script{
                    sh 'make deploy'
                    sh 'kubectl delete -f kubernetes/duo/duo.yml'
                    sh 'kubectl delete -f kubernetes/mongodb/mongo.yml'
                    sh 'kubectl delete -f kubernetes/redis/redis.yml'
                }
            }
        }
    }
}