pipeline {
    agent any  // Utiliza cualquier agente disponible (puede ser un nodo específico si lo prefieres)

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-id')  // Aquí se definen las credenciales de Docker Hub
        DOCKER_IMAGE_NAME = 'my-app'  // Nombre de la imagen Docker que quieres construir
    }

    tools {
        maven 'Maven'  // Especifica la herramienta de Maven configurada previamente en Jenkins
        // Asegúrate de que el nombre 'Maven' coincida con el nombre configurado en Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Clonar el repositorio Git que contiene el código fuente
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                // Ejecuta Maven para limpiar y construir el proyecto
                sh 'mvn clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Construir la imagen Docker
                script {
                    // Construir la imagen Docker usando el Dockerfile en el proyecto
                    sh 'docker build -t $DOCKER_IMAGE_NAME .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                // Iniciar sesión en Docker Hub usando las credenciales almacenadas
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        echo 'Successfully logged in to Docker Hub'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // Empujar la imagen construida a Docker Hub
                script {
                    // Etiquetar la imagen antes de enviarla
                    sh 'docker tag $DOCKER_IMAGE_NAME:latest $DOCKERHUB_CREDENTIALS_USR/$DOCKER_IMAGE_NAME:latest'
                    // Subir la imagen
                    sh 'docker push $DOCKERHUB_CREDENTIALS_USR/$DOCKER_IMAGE_NAME:latest'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Please check the logs.'
        }

        always {
            cleanWs()  // Limpiar el workspace después de la ejecución
        }
    }
}
