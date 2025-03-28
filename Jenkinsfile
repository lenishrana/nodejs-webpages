pipeline {
    agent any
    
    tools {
        nodejs "nodejs-10"
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', changelog: false, credentialsId: 'git-cred', poll: false, url: 'https://github.com/lenishrana/nodejs-webpages.git'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
        
         stage('Owasp Dependency check') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ ', odcInstallation: 'DP'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        
         stage('Docker Build & Push') {
            steps {
                script {
                    withDockerregistry(credentialsId: '  ', toolName: 'docker') {                                     # add credentials using Jenkins pipeline syntax

                        sh "docker build -t demonodejs ."
                        sh "docekr tag demonodejs lenishrana/nodejs:latest"
                        sh "docker push lenishrana/nodejs:latest"
                    }
                }

                 stage('Docker Deploy') {
            steps {
                script {
                    withDockerregistry(credentialsId: '  ', toolName: 'docker') {                                     # add credentials using Jenkins pipeline syntax

                        sh "docker run -d --name demo-nodejs -p 8081:8081 lenishrana/nodejs:latest"
                    }
                }
            }
        }
    }
}
