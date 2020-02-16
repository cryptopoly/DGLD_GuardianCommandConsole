 
# set -x # debug

while true; do
	echo "Enter Blockheight for Blockhash ('00' to exit)"
	read blockheight
	if [[ -z $blockheight ]] ; then exec
	elif [[ $blockheight == "00" ]] ; then exit ; echo "Exiting DGLD Command Launcher"; echo ""; exit
	elif ! (($blockheight >= 0 && $blockheight <= $blockheight)) ; then exec
else
	docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getblockhash $blockheight
	# osascript -e 'display notification "Blockhash: '$blockhash'" with title "GoldNode"'
	echo ""
fi
done
