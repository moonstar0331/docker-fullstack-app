node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Build image') {
        frontend = docker.build("moonsungkim/frontend", "./frontend/")
        backend = docker.build("moonsungkim/backend", "./backend/")
        mysql = docker.build("moonsungkim/mysql", "./mysql/")
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
