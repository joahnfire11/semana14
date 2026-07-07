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
                    WORKDIR="${WORKSPACE:-$PWD}"
                    echo "Usando workspace: $WORKDIR"

                    if [ ! -f "$WORKDIR/package.json" ]; then
                        echo "No se encontró package.json en $WORKDIR"
                        exit 1
                    fi

                    if command -v npm >/dev/null 2>&1; then
                        cd "$WORKDIR"
                        npm install
                    else
                        docker run --rm -v "$WORKDIR":/workspace -w /workspace node:22-alpine sh -lc "npm install"
                    fi
                '''
            }
        }

        stage('Ejecutar tests') {
            steps {
                sh '''
                    WORKDIR="${WORKSPACE:-$PWD}"
                    echo "Usando workspace: $WORKDIR"

                    if [ ! -f "$WORKDIR/package.json" ]; then
                        echo "No se encontró package.json en $WORKDIR"
                        exit 1
                    fi

                    if command -v npm >/dev/null 2>&1; then
                        cd "$WORKDIR"
                        npm test
                    else
                        docker run --rm -v "$WORKDIR":/workspace -w /workspace node:22-alpine sh -lc "npm test"
                    fi
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