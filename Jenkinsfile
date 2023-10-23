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
//              frontend.push("${env.BUILD_NUMBER}")
             frontend.push("${currentBuild.number}")
             frontend.push("latest")

             backend.push("${currentBuild.number}")
             backend.push("latest")

             mysql.push("${currentBuild.number}")
             mysql.push("latest")
         }
     }

     stage('K8S Manifest Update') {
        // git 계정 로그인, 해당 리포지토리의 main 브랜치에서 클론
        git credentialsId: 'k8s_manifest_git',
        url: 'https://github.com/moonstar0331/docker-fullstack-app-manifest.git',
        branch: 'main'

        // 이미지 태그 변경 후 메인 브랜치에 푸시
        sh "rm -rf .git"
        sh "git init"
        sh "git config --global user.email 'moonsung0331@gmail.com'"
        sh "git config --global user.name 'moonstar0331'"
        sh "sed -i 's/frontend:./frontend:${currentBuild.number}/g' web-deployment.yaml"
        sh "sed -i 's/backend:./backend:${currentBuild.number}/g' api-deployment.yaml"
        sh "sed -i 's/mysql:./mysql:${currentBuild.number}/g' mysql-deployment.yaml"

        sh "git add ."
        sh "git commit -m '[UPDATE] k8s ${currentBuild.number} image versioning'"
        sh "git branch -M main"
        sh "git remote remove origin"
//         sh "git remote set-url origin git@github.com:moonstar0331/docker-fullstack-app-manifest.git"
        sh "git remote add origin git@github.com:moonstar0331/docker-fullstack-app-manifest.git"
        sh "git push -u origin main"
     }
}

// pipeline {
//     agent any
//
//     environment {
//         dockerHubRegistry = 'moonsungkim'
//         dockerHubRegistryCredential = 'docker-hub'
//         githubCredential = 'k8s_manifest_git'
//         gitEmail = 'moonsung0331@gmail.com'
//         gitName = 'moonstar0331'
//     }
//
//     stages {
//         stage('Clone repository') {
//             steps {
//                 checkout scm
//             }
//         }
//
//         stage('Build image') {
//             steps {
//                 sh "docker build -t ${dockerHubRegistry}/frontend:${currentBuild.number} ./frontend/"
//                 sh "docker build -t ${dockerHubRegistry}/backend:${currentBuild.number} ./backend/"
//                 sh "docker build -t ${dockerHubRegistry}/mysql:${currentBuild.number} ./mysql/"
//             }
//         }
//
//         stage('Push image') {
//             steps {
//                 withDockerRegistry(credentialsId: dockerHubRegistryCredential, url: "https://registry.hub.docker.com") {
//                     sh "docker push ${dockerHubRegistry}/frontend:${currentBuild.number}"
//                     sh "docker push ${dockerHubRegistry}/frontend:latest"
//
//                     sh "docker push ${dockerHubRegistry}/backend:${currentBuild.number}"
//                     sh "docker push ${dockerHubRegistry}/backend:latest"
//
//                     sh "docker push ${dockerHubRegistry}/mysql:${currentBuild.number}"
//                     sh "docker push ${dockerHubRegistry}/mysql:latest"
//                 }
//             }
//         }
//
//         stage('K8S Manifest Update') {
//             steps {
//                 // git 계정 로그인, 해당 리포지토리의 main 브랜치에서 클론
//                 git credentialsId: githubCredential,
//                 url: 'https://github.com/moonstar0331/docker-fullstack-app-manifest',
//                 branch: 'main'
//
//                 // 이미지 태그 변경 후 메인 브랜치에 푸시
//                 sh "sed -i 's/frontend:./frontend:${currentBuild.number}/g' web-deployment.yaml"
//                 sh "sed -i 's/backend:./backend:${currentBuild.number}/g' api-deployment.yaml"
//                 sh "sed -i 's/mysql:./mysql:${currentBuild.number}/g' mysql-deployment.yaml"
//
//                 sh "git add ."
//                 sh "git commit -m '[UPDATE] k8s ${currentBuild.number} image versioning'"
//                 sh "git branch -M main"
//                 sh "git remote set-url origin https://github.com/moonstar0331/docker-fullstack-app-manifest"
//                 sh "git push -u origin main"
//             }
//         }
//     }
// }