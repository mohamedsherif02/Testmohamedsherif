pipeline {
    agent any
    
    environment {
        INTEGRATOR_EMAIL = 'ahmeds.elnozahy@gmail.com'  // Set your integrator's email here
    }
// tools {
//     allure 'Allure'
// }
    stages {
        stage('Setup') {
            steps {
                script {
                    // Create the hello_world.py script
                    writeFile file: 'hello_world.py', text: 'print("Hello, World!")'
                }
            }
        }
        stage('Hello') {
            steps {
                echo 'Running Python Script'
                sh 'python3 hello_world.py'
            }
        }
         stage('Allure and pytest') {
            steps {
                sh '''
                
                
                '/Library/Frameworks/Python.framework/Versions/3.12/bin/pytest'   test_integration.py || true
                '/Library/Frameworks/Python.framework/Versions/3.12/bin/pytest' --alluredir allure_results || true
                



                 '''
            }
        }


        
        stage('Generate Allure Report') {
      steps {
          sh 'bash'
          allure includeProperties: true, jdk: '', results: [[path: 'allure_results']]
      }
  }
        stage('Determine Committer Email') {
            steps {
                script {
                    // Get the committer's email from the latest commit
                    def committerEmail = sh(script: "git log -1 --pretty=format:'%ae'", returnStdout: true).trim()
                    env.COMMITTER_EMAIL = committerEmail
                }
            }
        }

        stage('Email notification') {
            steps {
                script{
                    def recipientEmails = "${env.INTEGRATOR_EMAIL},${env.COMMITTER_EMAIL}"
                mail(
                    to: recipientEmails,
                    subject: "${env.JOB_NAME} - Build #${env.BUILD_NUMBER} - ${currentBuild.currentResult}",
                    body: """
                        <p>Build ${env.BUILD_NUMBER} for job <b>${env.JOB_NAME}</b> finished with status: ${currentBuild.currentResult}</p>
                        <p>Branch: ${env.BRANCH_NAME}</p>
                        <p>Commit: ${env.GIT_COMMIT}</p>
                        <p>Check console output at <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                    """,
                    mimeType: 'text/html'
        )
    }
}
}

 
    }
}

