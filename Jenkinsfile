pipeline {
    agent none
    tools{
        maven "mymaven"
    }
    environment{
        DEV_SERVER_IP='ec2-user@172.31.27.216'
    }
    parameters{
        string(name: 'Env', defaultValue: 'test', description: 'Env to deploy')
        booleanParam(name: 'execute tests', defaultValue: true, description: 'decide to run tc')
        choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'APPVERSION')
    }
    stages {
        stage('compile') { //runs on jenkins-master-/var/lib/jenkins/workspace
        agent any    
            steps {
                echo "Compile the code in ${params.Env}"
                sh "mvn compile"
            }
        }
        stage('test') { //runs on jenkins-slave-tmp/workspace
        when {
            expression{
                params.executeTests == true
            }
        }    
        agent {label 'jenkins-slave'}    
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
        stage('package') {  //runs on jenkins-slave2,but workspace will be jenkins-master-/var/lib/jenkins/workspace
        //agent {label 'jenkins-slave'}
        agent any   
           input{
             message " select the version to deploy"
             ok "version selected"
             parameters{
                choice(name:'NEWAPP',choices:['1.2','2.1','3.1'])
             }
           }  
            steps {
                script{
                    sshagent(['jenkins-slave2']){

                echo "Package the code ${params.APPVERSION}"
                sh "scp -o StrictHostKeyChecking=no server-script.sh ${DEV_SERVER_IP}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER_IP} 'bash ~/server-script.sh'"
                sh "mvn package"
                    }
                }
            }
        }
    }        
}
