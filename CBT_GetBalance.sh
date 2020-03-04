#!/bin/bash 
 
# set -x # debug

echo 'CBT Balance:'
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getbalance
Balance=$(docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getbalance)
# osascript -e 'display notification "Balance Retrieved" with title "GoldNode"'
echo ""
