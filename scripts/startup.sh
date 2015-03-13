#!/bin/bash
set -x
if [ ! -f /data/minecraft_server.jar ] ; then 
	cp /server/minecraft_server.jar /data/
fi

if [ ! -f /data/eula.txt ] ; then 
	cp /server/eula.txt /data/
fi

if [ ! -f /data/server.properties ] ; then
	/configure.sh
fi

cd /data/
java -Xmx${MEMORY} -jar minecraft_server.jar nogui
