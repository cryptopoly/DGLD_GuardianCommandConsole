# set -x # debug

echo 'DGLD Command List'
docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass help
echo ""	
