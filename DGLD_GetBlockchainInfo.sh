 
# set -x # debug

echo 'BlockchainInfo:'
$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean  getblockchaininfo
Blockcount=$($HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean  getblockcount)
# osascript -e 'display notification "Blockcount '$Blockcount'" with title "GoldNode"'
