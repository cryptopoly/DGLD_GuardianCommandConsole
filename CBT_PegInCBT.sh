 
# set -x # debug
clear
while true; do
	echo "Step 1 - Export the private key of the ethereum address that owns the CBT tokens. This should be in hex format, e.g. 0xcb850d9db23b54ebbeae09995f7192af83646f9ea232645bb5a71699e5c15a6e"
	echo ""
	echo "Step 2 - Paste the private key here WITHOUT the 0x at the beginning  - 'cb850d9db23b54ebbeae09995f7192af83646f9ea232645bb5a71699e5c15a6e'"
	echo ""
	read ethcbtprivkey
	echo ""
if [[ -z $ethcbtprivkey ]] ; then exec
	elif [[ $ethcbtprivkey == "00" ]] ; then exit ; echo "Exiting DGLD Command Launcher"; echo ""; exit
	elif ! (($ethcbtprivkey >= 0 && $ethcbtprivkey <= $ethcbtprivkey)) ; then exec
	else	
	docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getethpeginaddress $ethcbtprivkey
	echo "Step 3 - Pay the CBT tokens to the eth_mainchain_address returned from the getethpeginaddress RPC and save the transaction id. The transaction will require a minimum amount of 10 confirmations before being allowed to peg-in."
	# Confirm to continue command
	read -n 1 -s -r -p "Press any key to continue"
	echo ""
	echo ""
	

# Step 4

# Run the claimethpegin RPC using the eth_claim_pubkey returned above, the transaction id and the CBT amount as:

# ocean-cli claimethpegin $txid $amount 03664b8a3e065329c6bb3b8f9f0bb382179775f609ffa9ff564ea6f20e913ec04b
# Step 5

# Run the getbalance RPC and verify that the CBT has been pegged in to the Ocean network.

# Step 6

# To peg-out this CBT will require running the sendtoethmainchain RPC specifying an address to send the CBT to as well as the amount to peg-out:

# ocean-cli sendtoethmainchain 8e8a0ec05cc3c2b8511aabadeeb821df19ea7564 0.1



# Confirm to continue command
read -n 1 -s -r -p "Press any key to continue"
echo ""
echo ""
fi
done