#!/bin/sh

mysql_install_db --user=root
MYSQL_ROOT_PASSWORD=password
mkdir -p /run/mysqld
  cat << EOF > mysql_installation_file
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
EOF
/usr/bin/mysqld --user=root --bootstrap --verbose=0 < mysql_installation_file
rm -f mysql_installation_file
for f in /sql/*; do
    /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $f
done
exec /usr/bin/mysqld --user=root --console