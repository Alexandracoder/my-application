pipeline {
    agent any  // Ejecuta el pipeline en cualquier nodo disponible

    tools {
        maven 'Maven'  // Usa la instalación de Maven configurada en Jenkins
    }

    environment {
        // Define variables de entorno si es necesario
        // Por ejemplo, si necesitas algún valor para conectar a un servidor:
        // MY_VARIABLE = 'some_value'
    }

    stages {
        stage('Checkout') {  // Etapa para obtener el código fuente desde Git
            steps {
                checkout scm  // Realiza el checkout del código desde el repositorio Git configurado
            }
        }
        
        stage('Build') {  // Etapa para compilar el proyecto con Maven
            steps {
                script {
                    // Asegúrate de tener Maven configurado y ejecutarlo correctamente
                    sh 'mvn clean install'  // Ejecuta el comando de Maven para construir el proyecto
                }
            }
        }

        stage('Test') {  // Etapa de pruebas con Maven
            steps {
                script {
                    // Ejecuta las pruebas unitarias con Maven
                    sh 'mvn test'  // Ejecuta el comando de pruebas de Maven
                }
            }
        }

        stage('Docker Build') {  // Etapa para construir la imagen Docker
            steps {
                script {
                    // Construir la imagen Docker si necesitas hacer un build
                    sh 'docker build -t my-app .'  // Reemplaza 'my-app' con el nombre de tu imagen
                }
            }
        }

        stage('Docker Push') {  // Etapa para enviar la imagen Docker a DockerHub
            steps {
                script {
                    // Si estás usando DockerHub, asegúrate de tener configuradas las credenciales
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                        sh 'docker push my-app'  // Reemplaza 'my-app' con el nombre de tu imagen
                    }
                }
            }
        }

        stage('Deploy') {  // Etapa de despliegue (ajústalo según tu necesidad)
            steps {
                script {
                    // Simula un despliegue (ajusta según tu caso)
                    echo 'Deploying application'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for more details.'
        }
    }
}

    }
}
