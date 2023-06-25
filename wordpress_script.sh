#!/bin/bash

# Check if docker is installed

if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing Docker..."

# Adding commands here to install Docker 

    sudo apt-get update
    sudo apt-get install docker.io -y
fi

# Check if docker-compose is installed

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Installing Docker Compose..."

 # Adding commands here to install Docker Compose
    sudo apt-get update
    sudo apt-get install docker-compose -y
fi

# Check if both Docker and Docker Compose are installed

if ! command -v docker &> /dev/null || ! command -v docker-compose &> /dev/null; then
    echo "Failed to install Docker and/or Docker Compose. Exiting."
    exit 1
fi

# Check if the site name argument is provided

if [ $# -ne 1 ]; then
  echo "Please provide a site name as an argument."
  exit 1
fi

site_name=$1

sudo sh -c "echo '127.0.0.1 $site_name' >> /etc/hosts"

site_dir="/var/www/$site_name"
sudo mkdir -p "$site_dir"

# Create docker-compose.yml file
cat <<EOF > docker-compose.yml
version: '3'
services:
  wordpress:
    image: wordpress:latest
    ports:
      - 80:80
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: admin
      WORDPRESS_DB_PASSWORD: admin123
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - "$site_dir:/var/www/html"
    depends_on:
      - db
  


