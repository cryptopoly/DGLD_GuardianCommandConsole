#!/bin/bash 
# set -x # debug

echo 'DGLD Dump KYC File'
docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass dumpkycfile /home/bitcoin/.bitcoin/kycfile
echo ""	
echo "The KYC File can be found here: /dgld/mainnet/ocean/kycfile"