
echo 'Get Bid Requests'
docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getbidrequests
echo ""
