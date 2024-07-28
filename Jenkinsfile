pipeline {
    agent any

    environment {
        GITHUB_REPO = '<Testmohamedsherif>'
        GITHUB_CREDENTIALS = '<mohamedsherif02>'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    // Replace with your build steps
                    sh 'make build'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Replace with your test steps
                    sh 'make test'
                }
            }
        }
    }

    post {
        success {
            script {
                def changeRequest = github.pullRequest '<pull-request-id>'
                changeRequest.merge('Merging PR as build is successful')
            }
        }

        failure {
            script {
                def changeRequest = github.pullRequest '<pull-request-id>'
                changeRequest.comment('Build failed. Please check the Jenkins logs for more details.')
            }
        }
    }
}
