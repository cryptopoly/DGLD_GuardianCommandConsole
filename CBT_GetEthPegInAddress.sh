 
# set -x # debug

while true; do
	echo "Step 1 - Export the private key of the ethereum address that owns the CBT tokens. This should be in hex format, e.g. 0xcb850d9db23b54ebbeae09995f7192af83646f9ea232645bb5a71699e5c15a6e"
	echo ""
	echo "Paste the private key here WITHOUT the 0x at the beginning  - 'cb850d9db23b54ebbeae09995f7192af83646f9ea232645bb5a71699e5c15a6e'"
	read ethcbtprivkey
else
	docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getethpeginaddress $blockheight
	# osascript -e 'display notification "Blockhash: '$blockhash'" with title "GoldNode"'
	echo ""
fi
done
