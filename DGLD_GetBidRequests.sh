
echo 'DGLD Dump KYC File'
docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getbidrequests
echo ""
