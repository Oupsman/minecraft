set -x
cat /server/server.properties | sed -e "s/enable-command-block=false/enable-command-block=${CMDBLOCK}/" -e "s/gamemode=0/gamemode=${MODE}/" > /data/server.properties
