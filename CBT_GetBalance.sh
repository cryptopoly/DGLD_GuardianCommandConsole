 
# set -x # debug

echo 'CBT Balance:'
$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb getbalance
Balance=$($HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb getbalance)
# osascript -e 'display notification "Balance Retrieved" with title "GoldNode"'
echo ""
