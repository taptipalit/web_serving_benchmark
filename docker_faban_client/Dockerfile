FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

ENV web_server 192.168.100.3

RUN apt-get update && apt-get install -y \
	build-essential wget \
	openjdk-7-jdk

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Setup Faban 

RUN wget http://faban.org/downloads/faban-kit-latest.tar.gz
RUN tar zxvf faban-kit-latest.tar.gz

COPY files/Web20Driver.jar /faban/benchmarks/
COPY files/Usergen.jar ./
COPY files/usersetup.properties /faban/

# Run user-generation to pre-generate users in Elgg
WORKDIR /faban
java -jar Usergen.jar ${web_server}

# Start Faban
RUN ./master/bin/startup.sh

CMD bash





