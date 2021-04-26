pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t wishapp:${BUILD_NUMBER} .'
      }
    }

    stage('Deploy') {
      steps {
        script {
          def CHECK_CONTAINER_EXIST = sh (returnStatus: true, script: "docker ps -a | grep 'wish'")
          if(CHECK_CONTAINER_EXIST!=0){
            sh 'docker run -d --name wish -p 4040:80 wishapp:${BUILD_NUMBER}'
            sh 'docker ps'
          } else{
            sh'docker rm -f $(docker ps | grep "wish" | docker ps -q) && docker run -d --name wish -p 4040:80 wishapp:${BUILD_NUMBER}'
            sh 'docker ps'
          }
        }

      }
    }

  }
}