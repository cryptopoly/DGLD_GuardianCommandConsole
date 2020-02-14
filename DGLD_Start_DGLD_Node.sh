
if pgrep -x "oceand" | grep -v pgrep >&-
then
	echo "Ocean server already online"
	echo -e
else
	docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass -v &
	echo "Ocean server starting..."
	echo -e
	sleep 2
	blockcount=$(docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getblockcount)
	sleep 2
	echo "Blockcount =" "$blockcount"
	# osascript -e 'display notification "GoldNode has started with Blockcount '$blockcount'" with title "GoldNode"'
	exit
fi
