pipeline {
    agent none
    tools{
        maven "mymaven"
    }
    parameters{
        string(name: 'Env', defaultValue: 'test', description: 'Env to deploy')
        booleanParam(name: 'execute tests', defaultValue: true, description: 'decide to run tc')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'APPVERSION')
    }
    stages {
        stage('compile') {
        agent any    
            steps {
                echo "Compile the code in ${params.Env}"
                sh "mvn compile"
            }
        }
        stage('test') {
        when {
            expression{
                params.executeTests == true
            }
        }    
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
                echo "Package the code ${params.APPVERSION}"
                sh "mvn package"
            }
        }
    }        
}
