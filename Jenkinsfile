node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Build image') {
        steps{
            dir('/frontend/') {
                script {
                    frontend = docker.build("moonsungkim/frontend")
                }
            }

            dir('/backend/') {
                script {
                    backend = docker.build("moonsungkim/backend")
                }
            }

            dir('/mysql/') {
                script {
                    mysql = docker.build("moonsungkim/mysql")
                }
            }
        }
     }
     stage('Push image') {
         docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
             frontend.push("${env.BUILD_NUMBER}")
             front.push("latest")

             backend.push("${env.BUILD_NUMBER}")
             backend.push("latest")

             mysql.push("${env.BUILD_NUMBER}")
             mysql.push("latest")
         }
     }
}
//
// stage('Build image') {
//   app = docker.build("gasbugs/flask-example")
// }
//
// stage('Push image') {
//   docker.withRegistry('https://registry.hub.docker.com', 'docker-hub')
//   {
//      app.push("${env.BUILD_NUMBER}")
//      app.push("latest")
//   }
// }
