pipeline {
    agent any 

    parameters {
      string(name: 'param1', defaultValue: 'not set')
      string(name: 'param2', defaultValue: 'not set')
    }

    stages {
        stage('Build') { 
            steps {
                println "Parameter1 value : ${param1}"
                println "Parameter2 value : ${param2}"
            }
        }
        stage('Test'){
            steps {
                echo 'Test step'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy step'
                echo 'job is running'
                 echo 'job is running .....'
                echo 'job is running .....1111'
            }
        }
    }

}
