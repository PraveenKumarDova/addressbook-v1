pipeline {
    agent none
    tools{
        maven "mymaven"
    }
    stages {
        stage('compile') {
        agent any    
            steps {
                echo "Compile the code"
                sh "mvn compile"
            }
        }
        stage('test') {
        agent any    
            steps {
                echo "Test the code"
                sh "mvn test"
            }
        }
        stage('package') {
        agent {label 'jenkins-slave'}    
            steps {
                echo "Package the code"
                sh "mvn package"
            }
        }
    }        
}
