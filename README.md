# WordPress Deployment Script
This script automates the deployment of a WordPress site using Docker and Docker Compose. It sets up a LEMP stack (Linux,MySQL,PHP) running inside containers and allows you to create, enable/disable, and delete WordPress sites.

#Prerequisites

Ensure that Docker is installed on your system

Make sure Docker Compose is also installed

# Clone the repository:
# Github Url - https://github.com/pranaydeo/wordpress_script.git
git clone https://github.com/pranaydeo/wordpress_script.git

# Change into the project directory
cd wordpress_script 

# Give permission to the script which you have cloned
sudo chmod 777 wordpress_script.sh

# Excuting the Script & create a wordpress site
sudo ./wordpress_script.sh example.com

# To check the status of the containers:
sudo docker-compose ps


