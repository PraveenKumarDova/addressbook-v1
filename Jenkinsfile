pipeline {
    agent any
    stages {
        stage('compile') {
            steps {
                echo "Compile the code"
                sh "mvn compile"
            }
        }
        stage('test') {
            steps {
                echo "Test the code"
                sh "mvn test"
            }
        }
        stage('package') {
            steps {
                echo "Package the code"
                sh "mvn package"
            }
        }
    }        
}
