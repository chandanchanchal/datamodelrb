sudo apt update -y
sudo apt install mysql-server

  sudo mysql

SELECT user, host, plugin FROM mysql.user WHERE user = 'root';

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password123';
FLUSH PRIVILEGES;

sudo snap install dbeaver-ce
