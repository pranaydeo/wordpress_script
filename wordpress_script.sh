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
   db:
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: admin
      MYSQL_DATABASE: wordpress
      MYSQL_USER: admin
      MYSQL_PASSWORD: admin123
    volumes:
      - db_data:/var/lib/mysql
volumes:
  db_data:
EOF 

# Start the containers
sudo docker-compose up -d

# Check if the containers are running
if sudo docker-compose ps | grep -q "Up"; then
   echo "WordPress site $site_name has been created successfully."

  # Prompt the user to open the site in a browser
    echo "Please open http://$site_name in a browser to access the site."

    # Additional subcommand to enable/disable the site
    read -p "Do you want to enable or disable the site? (enable/disable): " enable_disable
    case $enable_disable in
        enable)
            sudo docker-compose start
            echo "The site $site_name has been enabled."
            ;;
        disable)
            sudo docker-compose stop
            echo "The site $site_name has been disabled."
            ;;
        *)
            echo "Invalid option. The site $site_name remains unchanged."
            ;;
    esac
