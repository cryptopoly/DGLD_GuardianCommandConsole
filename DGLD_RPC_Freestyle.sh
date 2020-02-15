
echo "Enter RPC command e.g. getblockchaininfo, ('00' to exit)"
read freestyle
docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass $freestyle
echo ""

