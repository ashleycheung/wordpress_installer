sudo apt-get update
sudo apt-get upgrade

# Install apache2
echo "Installing Apache2"
sudo apt-get install apache2
sudo systemctl start apache2

# Configure firewall
echo "Configuring firewall"
sudo ufw app list
sudo ufw allow 'Apache'
sudo ufw status

# Install mysql
echo "Installing mysql"
sudo apt-get install mysql-server
sudo systemctl start mysql

# Install php8.1
echo "Installing php8.1"
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.1 -y

# Install wordpress
echo "Installing wordpress"
sudo wget -c http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo mv wordpress/* /var/www/html

# Set privileges
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 775 /var/www/html

echo "Copy the following to mysql"
echo "CREATE DATABASE wp_dbname;"
echo "CREATE USER 'db_username'@'%' IDENTIFIED WITH mysql_native_password BY 'db_password';"
echo "GRANT ALL ON wp_dbname.* TO 'db_username'@'%';"
echo "FLUSH PRIVILEGES;"
echo "EXIT;"
sudo mysql -u root -p

echo "Setup wordpress config"
cd /var/www/html
sudo mv wp-config-sample.php wp-config.php
sudo nano wp-config.php

echo "Restarting apache2 and mysql ..."
sudo systemctl restart apache2.service
sudo systemctl restart mysql.service

echo "Installation complete"



