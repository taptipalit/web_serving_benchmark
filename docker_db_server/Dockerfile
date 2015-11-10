FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

ENV root_password root

# Install MySQL
RUN echo mysql-server mysql-server/root_password password ${root_password} | sudo debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password ${root_password} | sudo debconf-set-selections

RUN apt-get update && apt-get install -y \
	build-essential \
	mysql-server

# Allow it to listen from outer world
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Restart
RUN service mysql restart

# Create the database
RUN mysql -p${root_password} -e "create database ELGG_DB;"

RUN mysql -p${root_password} ELGG_DB < files/elgg_db.dump

# Grant on all users

RUN mysql -p${root_password} -e "GRANT ALL PRIVILEGES ON *.* TO '${root_user}'@'%' IDENTIFIED BY '${root_password}' WITH GRANT OPTION;"

RUN service mysql restart

CMD bash





