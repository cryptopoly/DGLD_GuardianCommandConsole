
if pgrep -x "oceand" | grep -v pgrep >&-
then
	sudo docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass stop
	sleep 2
	if pgrep -x "oceand" | grep -v pgrep >&-; then echo killall oceand ;
else
	echo "Ocean server offline"
	# osascript -e 'display notification "goldnode has stopped successfully" with title "GoldNode"'; fi
else
	echo "Ocean server is not currently running"
	echo -e
fi
