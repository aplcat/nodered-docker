#!/bin/sh

# Update current user uid
sed -i "s/${USERNAME}:x:[0-9][0-9]*:/${USERNAME}:x:`id -u`:/" /etc/passwd

# Extra Runs
${RUNEXTRA:-echo "No extra runs"}

# Default exec
EXEC=${EXEC:-npm start --prefix /usr/src/node-red -- --userDir /data}

# Exec ARGS or EXEC
exec ${@:-$EXEC}