pipeline {
  agent any

  tools {
    maven 'myMaven'
  }
  
  parameters {
      string(name: 'Env', defaultValue: 'Test', description: 'Version to deploy')
      booleanParam(name: 'executeTests', defaultValue: true, description: 'Decide to run the test cases')
      choice(name: 'APPVERSION', choices: ['1.1', '1.2', '1.3'], description: 'Select Application Version')
  }
  

  stages {
    stage('compile') {
      agent any
      steps {
        script {
          echo "Compiling the code in ${params.Env} environments"
          sh "mvn compile"
        }
      }
    }

    stage('test') {
      agent any 
      when {
        expression { return params.executeTests == true }
      }
      steps {
        script {
          echo "Testing the code in ${params.Env} environments"
          sh "mvn test"
        }
      }
      post {
        always {
          junit 'target/surefire-reports/*.xml'
        }
      }
    }

    stage('CodeReview') {
      agent any
      steps {
        script {
          echo "CodeReview in ${params.Env} environments"
          sh "mvn pmd:pmd"
        }
      }
    }

    stage('CodeCoverageAnalysis') {
      agent any 
      steps {
        script {
          echo "CodeCoverageAnalysis in ${params.Env} environments"
          sh "mvn verify"
        }
      }
    }


    stage('package') {
      agent label 'jenkins-slave1'
      steps {
        script {
          echo "Packaging the code in ${params.APPVERSION} environments"
          sh "mvn package"
        }
      }
    }
  }
}

  
