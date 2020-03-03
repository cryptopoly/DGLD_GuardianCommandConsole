 # set -x # debug

echo 'DGLD Gold Total'
$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean getbalance
Balance=$($HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean getbalance)
# osascript -e 'display notification "Balance Retrieved" with title "GoldNode"'
echo ""
