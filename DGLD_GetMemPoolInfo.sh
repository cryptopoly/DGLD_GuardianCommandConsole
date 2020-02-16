 
# set -x # debug

docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getmempoolinfo
# osascript -e 'display notification "MemPool Information Retrieved" with title "Mem Pool"'
