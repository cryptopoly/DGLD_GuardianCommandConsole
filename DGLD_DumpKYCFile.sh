
echo 'DGLD Dump KYC File2'
sudo docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass dumpkycfile cheese
echo ""

