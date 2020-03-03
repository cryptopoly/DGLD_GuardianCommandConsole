 
# set -x # debug

echo 'BlockCount:'
$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean getblockcount

BlockCount=$($HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean getblockcount)
# osascript -e 'display notification "BlockCount '$BlockCount'" with title "GoldNode"'
