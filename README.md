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

# To start the containers:
sudo docker-compose start

# To stop the containers:
sudo docker-compose stop

#To delete the containers and associated volumes:
docker-compose down

Note :- To access the WordPress site running on the EC2 instance, you need to use the public IP address like http://<public-ip>
but please make sure to open the necessary inbound port (e.g., port 80) in your EC2 instance's security group to allow HTTP traffic to reach the instance.

