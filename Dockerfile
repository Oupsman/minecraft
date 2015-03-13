FROM oupsman/oracle-jdk-8

MAINTAINER Benoit SERRA (oupsman@oupsman.fr)

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 1.8.3
ENV MODE 0
ENV CMDBLOCK false
ENV MEMORY 512M 

RUN echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list
RUN wget -O - http://overviewer.org/debian/overviewer.gpg.asc | sudo apt-key add -
RUN apt-get --yes update; apt-get --yes upgrade; apt-get --yes install software-properties-common
RUN apt-get --yes install nginx
RUN apt-get --yes install minecraft-overviewer

VOLUME ['/data']
WORKDIR /data

# Creating the reference

RUN mkdir /server

# Downloading the server

RUN curl "https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/minecraft_server.${VERSION}.jar" -o /server/minecraft_server.jar

# and the texture pack

RUN wget https://s3.amazonaws.com/Minecraft.Download/versions/${VERSION}/${VERSION}.jar -P ~/.minecraft/versions/${VERSION}/

# Accept the licence

RUN echo "eula=true" > /server/eula.txt

ADD ./scripts/startup.sh /startup.sh
ADD ./scripts/configure.sh /configure.sh
ADD ./scripts/server.properties /server/server.properties

RUN chmod +x /startup.sh
RUN chmod +x /configure.sh

EXPOSE 25565

CMD ["/startup.sh"]

