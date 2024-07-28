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
post {
       success {
            script {
                def prNumber = env.CHANGE_ID
                def commitSHA = env.CHANGE_TARGET
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
