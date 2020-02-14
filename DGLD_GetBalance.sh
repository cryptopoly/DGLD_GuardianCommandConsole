
echo 'DGLD Balance'
docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getbalance
Balance=$(docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getbalance)
# osascript -e 'display notification "Balance Retrieved" with title "GoldNode"'
echo ""
