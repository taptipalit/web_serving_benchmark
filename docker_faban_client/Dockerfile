FROM ubuntu:14.04
MAINTAINER Tapti Palit <tpalit@cs.stonybrook.edu>

ENV web_server 192.168.100.3

RUN apt-get update && apt-get install -y \
	ant \
	build-essential \
	openjdk-7-jdk \
	wget

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Setup Faban 

RUN wget http://faban.org/downloads/faban-kit-latest.tar.gz
RUN tar zxvf faban-kit-latest.tar.gz

COPY files/web20_benchmark /web20_benchmark
#COPY files/usersetup.properties /faban/

#WORKDIR /web20_benchmark

# Build the Faban benchmark and the user-generation tool
RUN ant deploy.jar
RUN ant usergen-jar

# Copy files to their required locations
RUN cp /web20_benchmark/build/Web20Driver.jar /faban/benchmarks/

# Run user-generation to pre-generate users in Elgg
#WORKDIR /web20_benchmark/build
#RUN java -jar Usergen.jar http://${web_server}

WORKDIR /faban

#RUN ./master/bin/startup.sh

CMD bash




