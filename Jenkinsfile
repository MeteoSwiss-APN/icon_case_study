pipeline {
    agent none
    stages {
        stage('Tests') {
            matrix {
                agent { label "${NODENAME}" }
                axes {
                    axis {
                        name 'NODENAME'
                        values 'tsa', 'daint'
                    }
                }
                post {
                    always {
                        deleteDir()
                    }
                }
                stages {
                    stage('Execute') {
                        steps {
                            sh """
                            export JENKINS_DIR=$WORKSPACE
                            bash test.sh
                            """
                        }
                    }
                }
            }
        }
    }
}
