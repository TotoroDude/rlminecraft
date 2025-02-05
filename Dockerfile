FROM fithwum/debian-base:stretch
MAINTAINER fithwum

ENV ACCEPT_EULA="false"
ENV GAME_PORT=25555

# URL's for files
ARG INSTALL_SCRIPT=https://raw.githubusercontent.com/fithwum/minecraft/master/files/Install_Script.sh

# Install java8 & dependencies.
RUN apt-get -y update \
	&& apt-get install -y openjdk-8-jdk ca-certificates-java \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*\
	&& update-ca-certificates -f;

# folder creation.
RUN mkdir -p /MCserver /MCtemp \
	&& chmod 777 -R /MCserver /MCtemp \
	&& chown 99:100 -R /MCserver /MCtemp
ADD "${INSTALL_SCRIPT}" /MCtemp
RUN chmod +x /MCtemp/Install_Script.sh

# directory where data is stored
VOLUME /MCserver

# 25565 default.
EXPOSE 25555/udp 25555/tcp

# Run command
CMD [ "/bin/bash", "./MCtemp/Install_Script.sh" ]
