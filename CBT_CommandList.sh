#!/bin/bash 

# set -x # debug

echo 'CBT Command List'
docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass help
echo ""	
