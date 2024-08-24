#!/bin/bash

# Crear una red Docker personalizada
docker network create my-network || true

# Detener y eliminar los contenedores existentes si existen
docker stop my-microservice-container my-frontend-container 2>/dev/null
docker rm my-microservice-container my-frontend-container 2>/dev/null

# Construir la imagen Docker para el microservicio
docker build -t my-microservice1 -f ./my-microservice1/Dockerfile ./my-microservice1

# Ejecutar el contenedor del microservicio
docker run -d --network my-network -p 8080:80 --name my-microservice-container my-microservice1 #

# Construir la imagen Docker para el frontend
docker build -t my-frontend -f ./my-frontend/Dockerfile ./my-frontend

# Ejecutar el contenedor del frontend
docker run -d --network my-network -p 8081:80 --name my-frontend-container my-frontend

echo "Aplicación en ejecución:"

echo "Microservicio: http://localhost:8080/weatherforecast"
echo "Frontend: http://localhost:8081"

# Esperar un momento para que las aplicaciones se inicien
sleep 5

# Verificar si el microservicio está respondiendo
if curl -sSf http://localhost:8080/weatherforecast > /dev/null 2>&1; then
    echo "El microservicio está respondiendo correctamente."
else
    echo "Error: El microservicio no está respondiendo. Revisa los logs del contenedor."
    docker logs my-microservice-container
fi

# Verificar si el frontend está respondiendo
if curl -sSf http://localhost:8081 > /dev/null 2>&1; then
    echo "El frontend está respondiendo correctamente."
else
    echo "Error: El frontend no está respondiendo. Revisa los logs del contenedor."
    docker logs my-frontend-container
fi