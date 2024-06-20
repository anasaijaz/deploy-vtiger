FROM ubuntu:xenial

EXPOSE 3306
RUN apt update && apt upgrade -y 
RUN apt install telnet iputils-ping  mysql-client -y

RUN apt install htop nano curl git unzip nfs-common net-tools vim -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

RUN sed  -i "s/bind-address\(.*\)/#bind-address\1/" /etc/mysql/mysql.conf.d/mysqld.cnf 




ENTRYPOINT 	usermod -d /var/lib/mysql/ mysql && \
			chown -R mysql:mysql /var/lib/mysql && \
			chown mysql:mysql /etc/init.d/mysql && \
			service mysql start && mysqladmin -u root password 123 && \
			echo "create user root identified by '123';grant all privileges on *.* to 'root'@'%' with grant option;flush privileges;" | mysql -p123 && \
			/bin/bash
