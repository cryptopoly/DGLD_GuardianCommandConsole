# set -x # debug
clear
# script Log.txt

echo "Step 1"
echo "Export the private key of the ethereum address that owns the CBT tokens. This should be in hex format"
echo "e.g. '0xcb850d9db23b54ebbeae09995f7192af83646f9ea232645bb5a71699e5c15a6e'"
echo ""

echo "Step 2"
echo "Paste the ERC-20 private key here WITHOUT the 0x at the beginning (getethpeginaddress)"
echo "e.g. 'cb850d9db23b54ebbeae09995f7192af83646f9ea232645bb5a71699e5c15a6e':"
read ethcbtprivkey
echo ""
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getethpeginaddress $ethcbtprivkey
echo ""

echo "Step 3"
echo "Pay the CBT tokens to the eth_mainchain_address returned above (remember to add the '0x' at the beginning!) and save the Transaction ID to hand. The transaction will require a minimum amount of 10 confirmations before being allowed to peg-in."
echo ""
# Confirm to continue command
read -n 1 -s -r -p "Press any key to confirm CBT tokens have been sent to the eth_mainchain_address as above and the tx has 10 or more confirmations"
echo ""
echo ""

echo "Step 4"
echo "Claim the CBT Mainnet tokens with eth_claim_pubkey returned above, the transaction id and the CBT amount (claimethpegin):"
echo "e.g. 'ocean-cli claimethpegin [tx_id] [cbt_amount] [eth_claim_pubkey]'"
echo ""
echo "Enter the tx_id (without '0x'):"
read txid
echo ""
echo "Enter the CBT amount to Peg-In:"
read cbtamount
echo ""
echo "Enter the eth_claim_pubkey:"
read ethclaimpubkey
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass claimethpegin $ethclaimpubkey $txid $cbtamount
echo ""
# Confirm to continue command
read -n 1 -s -r -p "Press any key to continue"
echo ""
echo ""

echo "Step 5"
echo "Verify that the CBT has been pegged in to the Ocean network (getbalance):"
echo ""
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getbalance
echo ""
# Confirm to continue command
read -n 1 -s -r -p "Press any key to continue - to peg out please choose CBT_Peg_Out.sh from the main menu"
echo ""
echo ""


# Confirm to continue command
read -n 1 -s -r -p "Press any key to continue"
echo ""
echo ""

# sample txid = f24ea77da2a7746f64d44e72e3fbf1e7eb832bdc76121017226aa9a6c04e6348