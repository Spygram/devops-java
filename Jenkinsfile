pipeline {
    agent any

    tools {
        jdk 'jdk21' // Ensure this tool is configured in Jenkins Global Tool Configuration
        gradle 'gradle-814'
    }

    environment {
        APP_NAME = 'calculator'
        JAR_NAME = "calculator-1.0.0.jar"
    }

    stages {
        
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'gradle clean compileJava'
            }
        }

        stage('Test') {
            steps {
                echo 'Running unit tests...'
                sh 'gradle test'
            }
            post {
                always {
                    junit 'build/test-results/test/*.xml'
                    // jacoco execPattern: 'build/jacoco/test.exec',
                    //        classPattern: 'build/classes/java/main',
                    //        sourcePattern: 'src/main/java',
                    //        inclusionPattern: '**/*.class'
                }
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging the application into a JAR...'
                sh 'gradle bootJar'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to the target environment...'
                // Example: sh 'scp build/libs/${JAR_NAME} user@server:/path/to/deploy'
                // Example for Docker:
                // sh "docker build -t ${APP_NAME}:${BUILD_NUMBER} ."
                // sh "docker run -d -p 8080:8080 ${APP_NAME}:${BUILD_NUMBER}"
                // sh 'scp build/libs/${JAR_NAME} ubuntu@18.213.118.142:~/'
                // sh 'scp -o StrictHostKeyChecking=no build/libs/${JAR_NAME} ubuntu@3.222.177.224:~/'
                sshagent(credentials: ['deployer_key']) {
                    sh """
                        scp -o StrictHostKeyChecking=no \
                            build/libs/${JAR_NAME} \
                            ubuntu@3.222.177.224:~/
                    """
                    echo 'Deployment successful (placeholder).'
                }
            }
        }
    }    

    post {
        always {
            echo 'Pipeline finished execution.'
        }
        success {
            echo 'Build, Test, Package, and Deploy stages completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for more information.'
        }
    }
}
