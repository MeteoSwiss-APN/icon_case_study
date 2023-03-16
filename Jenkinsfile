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
                            export JENKINS_DIR="${WORKSPACE}"
                            bash prepare_case_study.sh 23030100 2
                            [ "$(find ${JENKINS_DIR}/input_icon/23030100 -name efsf00000000_lbc.nc)" ] && find ${JENKINS_DIR}/input_icon/23030100 -name efsf00000000_lbc.nc || (echo "No boundary file found in output folder" && exit 1) 
                            [ "$(find ${JENKINS_DIR}/input_icon/23030100 -name laf2023030100.*)" ] && find ${JENKINS_DIR}/input_icon/23030100 -name laf2023030100.* || (echo "No analysis file found in output folder" && exit 1) 
                            """
                        }
                    }
                }
            }
        }
    }
}
