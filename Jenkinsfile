pipeline {
    agent any

    environment {
        GITHUB_REPO = 'mohamedsherif02/Testmohamedsherif'
        GITHUB_CREDENTIALS = 'd326ca7e-a2bb-45c7-bf84-216d9a8d97bb'
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
                def prNumber = env.CHANGE_ID
                def commitSHA = env.GIT_COMMIT
                def githubToken = credentials(GITHUB_CREDENTIALS)
                
                // Merge the pull request
                sh """
                curl -X PUT -H "Authorization: token ${githubToken}" \
                -H "Accept: application/vnd.github.v3+json" \
                https://api.github.com/repos/${GITHUB_REPO}/pulls/${prNumber}/merge \
                -d '{ "commit_title": "Merging PR #${prNumber} - successful build", "sha": "${commitSHA}" }'
                """
            }
        }

        failure {
            script {
                def prNumber = env.CHANGE_ID
                def githubToken = credentials(GITHUB_CREDENTIALS)
                
                // Comment on the pull request
                sh """
                curl -X POST -H "Authorization: token ${githubToken}" \
                -H "Accept: application/vnd.github.v3+json" \
                https://api.github.com/repos/${GITHUB_REPO}/issues/${prNumber}/comments \
                -d '{ "body": "Build failed. Please check the Jenkins logs for more details." }'
                """
            }
        }
    }
}
