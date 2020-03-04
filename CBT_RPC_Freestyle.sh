#!/bin/bash 
 
# set -x # debug

echo "Enter RPC command e.g. getblockchaininfo, ('00' to exit)"
read freestyle
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass $freestyle
echo ""

