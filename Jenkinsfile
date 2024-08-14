pipeline {
    agent any

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
          allure includeProperties: true, jdk: '', results: [[path: 'allure_results']]
      }
  }


        
    }
}

