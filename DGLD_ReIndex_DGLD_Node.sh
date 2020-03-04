#!/bin/bash 
 
# set -x # debug

# Stop node
if pgrep -x "oceand" | grep -v pgrep >&-
then
	docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass stop
	sleep 1
	echo ""
	if pgrep -x "oceand" | grep -v pgrep >&-; then echo killall oceand
	sleep 2
	fi;
fi
# Start node and reindex
	docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass -v --reindex=1 &
	echo "Ocean server reindexing. Please wait for node to sync"
	sleep 2
	exit
