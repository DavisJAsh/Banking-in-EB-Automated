pipeline {
  agent any
    stages {
        stage ('Build') {
            steps {
                sh '''#!/bin/bash
                python3.7 -m venv Banking-V2_main
                source Banking-V2_main/bin/activate
                pip install pip --upgrade
                pip install -r requirements.txt
                '''
            }
        }
        stage ('Test') {
            steps {
                sh '''#!/bin/bash
                chmod +x system_resources_test.sh
                /home/ubuntu/Banking-in-EB-Automated/scripts/system_resources_test.sh
                '''
            }
        }
	stage ('Deploy') {
          steps {
              sh '''#!/bin/bash
              source Banking-V2_main/bin/activate
              eb create Banking-V2_main --single
              '''
          }
      }

    }
}
