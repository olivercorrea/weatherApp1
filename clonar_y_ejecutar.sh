#!/bin/bash

# URL del repositorio que deseas clonar
REPO_URL="https://github.com/olivercorrea/weatherApp1.git"

# Clonar el repositorio
git clone $REPO_URL

sleep 10

# Extraer el nombre del repositorio de la URL
REPO_NAME=$(basename $REPO_URL .git)

# Cambiar al directorio del repositorio clonado
cd $REPO_NAME || {
    echo "Error al entrar en el directorio $REPO_NAME"
    exit 1
}

# Ejecutar el script que se encuentra dentro del repositorio
# Asegúrate de que el script tenga permisos de ejecución
chmod +x deploy.sh
./deploy.sh
