# set -x # debug
clear
# script Log.txt

echo "Step 1"
echo "Pegging out requires specifying an ERC-20 address to send the CBT to as well as the amount to peg-out (sendtoethmainchain):
e.g. 'ocean-cli sendtoethmainchain 8e8a0ec05cc3c2b8511aabadeeb821df19ea7564 0.1'"
echo ""

echo "Enter the Ethereum ERC-20 address you wish to Peg-Out the CBT to (WITHOUT '0x'):"
read ethpegoutaddress
echo "Enter the CBT amount you wish to Pet-Out:"
read cbtamount
echo ""
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass sendtoethmainchain $ethpegoutaddress $cbtamount
echo ""
echo "New CBT Balance:"
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getbalance
echo ""
# Confirm to continue command
read -n 1 -s -r -p "Please check the ERC-20 balance in a few moments"
echo ""
echo ""