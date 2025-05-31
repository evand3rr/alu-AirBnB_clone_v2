#!/usr/bin/env bash
# script that sets up web servers for the deployment of web_static
sudo apt-get update
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'

# Create necessary directories
sudo mkdir -p /data/
sudo mkdir -p /data/web_static/
sudo mkdir -p /data/web_static/releases/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/test/

# Add test HTML file to the test folder
sudo touch /data/web_static/releases/test/index.html
sudo echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link to /data/web_static/current
sudo ln -s -f /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update the Nginx configuration to serve the content
sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/; }' /etc/nginx/sites-enabled/default

# Test the Nginx configuration to ensure there are no syntax errors
sudo nginx -t

# Restart Nginx to apply the changes
sudo service nginx restart

