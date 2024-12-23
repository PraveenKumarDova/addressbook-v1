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
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('package') {
        //agent {label 'jenkins-slave'}
        agent any     
            steps {
                echo "Package the code"
                sh "mvn package"
            }
        }
    }        
}
