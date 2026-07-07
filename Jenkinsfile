pipeline {
    agent any
 
    environment {
        // Obliga al cliente de Docker antiguo a comunicarse correctamente con Docker Desktop
        DOCKER_API_VERSION = '1.40'
    }
 
    tools {
        // Mantenemos tu herramienta de Docker para que provea el comando 'docker'
        dockerTool 'Dockertool'  
    }
 
    stages {
        stage('Construir Imagen Docker') {
            steps {
                sh 'docker build -t hola-mundo-node:latest .'
            }
        }
 
        stage('Ejecutar Contenedor Node.js') {
            steps {
                sh '''
                    # Detener y eliminar cualquier contenedor previo con el mismo nombre
                    docker stop hola-mundo-node || true
                    docker rm hola-mundo-node || true
 
                    # Ejecutar el nuevo contenedor de la aplicación
                    docker run -d --name hola-mundo-node -p 3000:3000 hola-mundo-node:latest
                '''
            }
        }
    }
}