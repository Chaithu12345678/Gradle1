pipeline {
    agent any

    stages {
        stage('Initialize'){
        def dockerHome = tool 'myDocker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
    }
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    docker.build('simple-gradle-java-app')
                }
            }
        }

        stage('Scan Image') {
            steps {
                script {
                    // Scan the Docker image for vulnerabilities
                    // Example using Anchore
                    anchoreImage('simple-gradle-java-app')
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run tests inside the Docker container
                    docker.image('simple-gradle-java-app').inside {
                        sh 'gradle test'
                    }
                }
            }
        }

        stage('Code Coverage') {
            steps {
                script {
                    // Generate code coverage report
                    docker.image('simple-gradle-java-app').inside {
                        sh 'gradle jacocoTestReport'
                    }
                }
            }
        }

        stage('Publish Coverage Report') {
            steps {
                script {
                    // Publish the coverage report (e.g., to Jenkins)
                    jacoco execPattern: '**/build/jacoco/*.exec', classPattern: '**/build/classes/java/main', sourcePattern: '**/src/main/java'
                }
            }
        }
    }
}
