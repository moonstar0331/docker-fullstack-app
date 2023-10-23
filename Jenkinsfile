// node {
//
//      stage('Clone repository') {
//          checkout scm
//      }
//
//      stage('Build image') {
//         frontend = docker.build("moonsungkim/frontend", "./frontend/")
//         backend = docker.build("moonsungkim/backend", "./backend/")
//         mysql = docker.build("moonsungkim/mysql", "./mysql/")
//      }
//
//      stage('Push image') {
//          docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
// //              frontend.push("${env.BUILD_NUMBER}")
//              frontend.push("${currentBuild.number}")
//              frontend.push("latest")
//
//              backend.push("${currentBuild.number}")
//              backend.push("latest")
//
//              mysql.push("${currentBuild.number}")
//              mysql.push("latest")
//          }
//      }
//
//      stage('K8S Manifest Update') {
//         // git 계정 로그인, 해당 리포지토리의 main 브랜치에서 클론
//         git credentialsId: 'k8s_manifest_git',
//         url: 'https://github.com/moonstar0331/docker-fullstack-app-manifest.git',
//         branch: 'main'
//
//         // 이미지 태그 변경 후 메인 브랜치에 푸시
//         sh "git config --global user.email 'moonsung0331@gmail.com'"
//         sh "git config --global user.name 'moonstar0331'"
//         sh "sed -i 's/frontend:./frontend:${currentBuild.number}/g' web-deployment.yaml"
//         sh "sed -i 's/backend:./backend:${currentBuild.number}/g' api-deployment.yaml"
//         sh "sed -i 's/mysql:./mysql:${currentBuild.number}/g' mysql-deployment.yaml"
//
//         sh "git add ."
//         sh "git commit -m '[UPDATE] k8s ${currentBuild.number} image versioning'"
//         sh "git branch -M main"
//         sh "git remote remove origin"
// //         sh "git remote set-url origin git@github.com:moonstar0331/docker-fullstack-app-manifest.git"
//         sh "git remote add origin git@github.com:moonstar0331/docker-fullstack-app-manifest.git"
//         sh "git push -u origin main"
//      }
// }
//

pipeline{
    agent any

    environment {
        dockerHubRegistry = 'moonsungkim'
        dockerHubRegistryCredential = 'docker-hub'
        githubCredential = 'k8s_manifest_git'
    }

    stages {
        stage('check out application git branch'){
            steps {
                checkout scm
            }
            post {
                failure {
                    echo 'repository checkout failure'
                }
                success {
                    echo 'repository checkout success'
                }
            }
        }

        stage('docker image build'){
            steps{
                sh "docker build -t ${dockerHubRegistry}/frontend:${currentBuild.number} ./frontend"
                sh "docker build -t ${dockerHubRegistry}/frontend:latest ./frontend"

                sh "docker build -t ${dockerHubRegistry}/backend:${currentBuild.number} ./backend"
                sh "docker build -t ${dockerHubRegistry}/backend:latest ./backend"

                sh "docker build -t ${dockerHubRegistry}/mysql:${currentBuild.number} ./mysql"
                sh "docker build -t ${dockerHubRegistry}/mysql:latest ./mysql"
            }
            post {
                    failure {
                      echo 'Docker image build failure !'
                    }
                    success {
                      echo 'Docker image build success !'
                    }
            }
        }
        stage('Docker Image Push') {
            steps {
                withDockerRegistry([ credentialsId: dockerHubRegistryCredential, url: "" ]) {
                    sh "docker push ${dockerHubRegistry}/frontend:${currentBuild.number}"
                    sh "docker push ${dockerHubRegistry}/frontend:latest"

                    sh "docker push ${dockerHubRegistry}/backend:${currentBuild.number}"
                    sh "docker push ${dockerHubRegistry}/backend:latest"

                    sh "docker push ${dockerHubRegistry}/mysql:${currentBuild.number}"
                    sh "docker push ${dockerHubRegistry}/mysql:latest"

                    sleep 10 /* Wait uploading */
                }
            }
            post {
                    failure {
                      echo 'Docker Image Push failure !'
                      sh "docker rmi ${dockerHubRegistry}/frontend:${currentBuild.number}"
                      sh "docker rmi ${dockerHubRegistry}/frontend:latest"

                      sh "docker rmi ${dockerHubRegistry}/backend:${currentBuild.number}"
                      sh "docker rmi ${dockerHubRegistry}/backend:latest"

                      sh "docker rmi ${dockerHubRegistry}/mysql:${currentBuild.number}"
                      sh "docker rmi ${dockerHubRegistry}/mysql:latest"
                    }
                    success {
                      echo 'Docker image push success !'
                      sh "docker rmi ${dockerHubRegistry}/frontend:${currentBuild.number}"
                      sh "docker rmi ${dockerHubRegistry}/frontend:latest"

                      sh "docker rmi ${dockerHubRegistry}/backend:${currentBuild.number}"
                      sh "docker rmi ${dockerHubRegistry}/backend:latest"

                      sh "docker rmi ${dockerHubRegistry}/mysql:${currentBuild.number}"
                      sh "docker rmi ${dockerHubRegistry}/mysql:latest"
                    }
            }
        }
        stage('K8S Manifest Update') {
            steps {
                sh "ls"
                sh 'mkdir -p gitOpsRepo'
                dir("gitOpsRepo")
                {
                    git branch: "main",
                    credentialsId: githubCredential,
                    url: 'https://github.com/moonstar0331/docker-fullstack-app-manifest.git'

                    sh "sed -i 's/web:.*\$/frontend:${currentBuild.number}/g' web-deployment.yaml"
                    sh "sed -i 's/api:.*\$/backend:${currentBuild.number}/g' api-deployment.yaml"
                    sh "sed -i 's/mysql:.*\$/mysql:${currentBuild.number}/g' mysql-deployment.yaml"

                    sh "git add ."
                    sh "git commit -m '[UPDATE] k8s ${currentBuild.number} image versioning'"
//                     sshagent(credentials: ['19bdc43b-f3be-4cb9-aa1d-9896f503e3e8']) {
//                         sh "git remote set-url origin git@github.com:skarltjr/kube-manifests.git"
//                         sh "git push -u origin main"
//                     }
                    withCredentials([gitUsernamePassword(credentialsId: githubCredential,
                                     gitToolName: 'git-tool')]) {
                        sh "git remote set-url origin https://github.com/moonstar0331/docker-fullstack-app-manifest"
                        sh "git push -u origin main"
                    }
                }
            }
            post {
                    failure {
                      echo 'K8S Manifest Update failure !'
                    }
                    success {
                      echo 'K8S Manifest Update success !'
                    }
            }
        }

    }
}