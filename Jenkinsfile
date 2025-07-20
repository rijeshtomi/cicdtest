pipeline {
    agent any
    parameters {
        string(name: 'ABORTED', defaultValue: 'SUCCESS')
    }
    stages {
        stage('Dev') {
            steps {
                script {
                    currentBuild.result = "${params.ABORTED}"
                }
            }
        }
    }
}
