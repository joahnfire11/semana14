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
        stage('Instalar dependencias') {
            steps {
                sh '''
                    cd "$WORKSPACE"
                    docker build -t hola-mundo-node:test .
                '''
            }
        }

        stage('Ejecutar tests') {
            steps {
                sh '''
                    docker run --rm hola-mundo-node:test sh -lc "npm test"
                '''
            }
        }

        stage('Construir Imagen Docker') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                sh 'docker build -t hola-mundo-node:latest .'
            }
        }
 
        stage('Ejecutar Contenedor Node.js') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
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