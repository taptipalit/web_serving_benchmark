FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

ENV root_password root

# Install MySQL
RUN echo mysql-server mysql-server/root_password password ${root_password} | sudo debconf-set-selections
RUN echo mysql-server mysql-server/root_password_again password ${root_password} | sudo debconf-set-selections

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	mysql-server

# Allow it to listen from outer world
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Copy the scripts
ADD files/execute.sh /execute.sh
ADD files/elgg_db.dump /elgg_db.dump

RUN chmod a+x /execute.sh

CMD bash -c "/execute.sh ${root_password}"





