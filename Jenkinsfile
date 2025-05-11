pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                script {
                    // Configura Maven con el archivo settings.xml desde la ubicación predeterminada
                    withEnv(["MAVEN_OPTS=-s $HOME/.m2/settings.xml"]) {
                        sh 'mvn clean install'
                    }
                }
            }
        }
    }
}

        }
        
        stage('Docker Build') {
            steps {
                // Aquí se construiría la imagen de Docker (si tienes un Dockerfile configurado)
                sh 'docker build -t my-application .'
            }
        }
        
        stage('Docker Push') {
            steps {
                // Aquí se haría el push de la imagen a DockerHub (si está configurado)
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    sh 'docker push my-application'
                }
            }
        }
    }
    
    post {
        success {
            echo '¡La construcción fue exitosa!'
        }
        failure {
            echo 'Hubo un error en la construcción.'
        }
    }
}
