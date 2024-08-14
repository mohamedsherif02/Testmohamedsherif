pipeline {
    agent any
environment {
    pytest = '/Library/Frameworks/Python.framework/Versions/3.12/bin/pytest'
}
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
                sh 'pytest test_integration.py'
                sh 'pytest --alluredir allure_results'
                sh 'allure serve'
            }
        }
    }
}

