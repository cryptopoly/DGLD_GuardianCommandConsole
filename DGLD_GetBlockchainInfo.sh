 
# set -x # debug

echo 'BlockchainInfo:'
docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass  getblockchaininfo
Blockcount=$(docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass  getblockcount)
# osascript -e 'display notification "Blockcount '$Blockcount'" with title "GoldNode"'
