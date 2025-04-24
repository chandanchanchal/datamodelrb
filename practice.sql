sudo apt update -y
sudo apt install mysql-server

SELECT user, host, plugin FROM mysql.user WHERE user = 'root';

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password123';
FLUSH PRIVILEGES;
