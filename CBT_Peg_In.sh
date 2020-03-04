#!/bin/bash 
# set -x # debug
clear
# script Log.txt

echo "CBT ERC-20 Peg-In to CBT Mainnet"
echo ""
echo 'CBT Balance:'
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getbalance
Balance=$(docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getbalance)
echo ""
echo "Step 1"
echo "Export the private key of the ethereum address that owns the CBT tokens. This should be in hex format"
echo "e.g. '0xcb850d9db23b54ebbeae09995f7192af83646f9ea232645bb5a71699e5c15a6e'"
echo ""

echo "Step 2"
echo "Paste the ERC-20 private key here WITHOUT the 0x at the beginning (getethpeginaddress)"
echo "e.g. 'cb850d9db23b54ebbeae09995f7192af83646f9ea232645bb5a71699e5c15a6e':"
read ethcbtprivkey


echo ""
# echo ""
eth_claim_pubkey=$(docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getethpeginaddress $ethcbtprivkey |\
jq -r '.eth_claim_pubkey')
eth_mainchain_address=$(docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getethpeginaddress $ethcbtprivkey |\
jq -r '.eth_mainchain_address')
echo "Ethereum claim public key:"
echo $eth_claim_pubkey
echo ""
echo "Ethereum mainchain address:"
echo -n "0x"
echo $eth_mainchain_address
echo ""

# WIP Etherscan API - https://api.etherscan.io/api?module=account&action=tokentx&contractaddress=0x076C97e1c869072eE22f8c91978C99B4bcB02591&address=0x9178afdf2fc2cbdde30290c0b49f040ff804e06c&page=1&offset=5&sort=desc&apikey=MRX1RQP9V1ZHXU5R9N14P4Q71NMCH4D7PF

echo "Step 3"
echo "Pay the CBT tokens to the eth_mainchain_address returned above and save the Transaction ID to hand. The transaction will require a minimum amount of 10 confirmations before being allowed to peg-in."
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
echo "Mainnet Tx broadcasted with Id:"
echo -n "https://cbtexplorer.com/tx/"
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass claimethpegin $txid $cbtamount $eth_claim_pubkey
echo ""

# Confirm to continue command
read -n 1 -s -r -p "To peg out please choose CBT_Peg_Out.sh from the main menu. Press any key to continue"
echo ""
echo ""
