 
# set -x # debug

echo "Enter RPC command e.g. getblockchaininfo, ('00' to exit)"
read freestyle
$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean $freestyle
echo ""

