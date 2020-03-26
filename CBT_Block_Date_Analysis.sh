#!/bin/bash 

# Note there is an 18 hour gap between genesis block and second block

endBlockHeight=$($HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb getrequests | jq -r ".[].endBlockHeight")
cbt_blockheight_node=$($HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb getblockcount)
unix_cbt_blockheight_seconds=$(($cbt_blockheight_node*60))
timeunix_genesisBlock=1579622400
timeunix_blockheight_genesis_currentdate=$(($unix_cbt_blockheight_seconds+$timeunix_genesisBlock))
date_genesisBlock=$(date -r $timeunix_genesisBlock)
unix_currentDate=$(date +%s)
date_currentDate=$(date)
unix_endBlockHeight=$(($timeunix_genesisBlock ++ ($endBlockHeight*60)))
date_endBlockHeight=$(date -r $unix_endBlockHeight)
blockdiff_confirmedBlockHeight=$(($confirmedBlockHeight-$cbt_blockheight_node))
blockdiff_startBlockHeight=$(($startBlockHeight-$cbt_blockheight_node))
blockdiff_endBlockHeight=$(($endBlockHeight-$cbt_blockheight_node))
days_endBlockHeight=$(($blockdiff_endBlockHeight/60/24))
hours_endBlockHeight=$(($blockdiff_endBlockHeight/60))
minutes_endBlockHeight=$(($blockdiff_endBlockHeight))
seconds_endBlockHeight=$(($blockdiff_endBlockHeight*60))
unix_Current_endBlockHeight=$(($unix_currentDate + $seconds_endBlockHeight))
date_Current_endBlockHeight=$(date -r $unix_Current_endBlockHeight)
genesis_current_blockheight_date=$(date -u -r $timeunix_genesisBlock -v +"$cbt_blockheight_node"M)
genesis_current_seconds_diff=$(($timeunix_blockheight_genesis_currentdate-$unix_currentDate))

echo "--Genesis Block/Current Dates--"
echo ""
echo "GenesisBlock unix timsetamp from conf... $timeunix_genesisBlock / $date_genesisBlock"
echo ""
echo "Curent Date... $unix_currentDate / $date_currentDate"

echo ""
echo "Current CBT Node BlockHeight... $cbt_blockheight_node blocks = $unix_cbt_blockheight_seconds unix seconds"

echo ""
echo "Current Date per GenesisBlock timestamp & current blockheight)... $timeunix_blockheight_genesis_currentdate / $genesis_current_blockheight_date"

echo ""
echo ""
echo "--Auction Dates--"
echo ""
echo "Auction Ends @ $endBlockHeight"

echo ""
echo "Block diff... ~$blockdiff_endBlockHeight blocks/minutes or ~$hours_endBlockHeight hours from now"
echo ""

echo "Auction End date based on current blockheight/timestamp...  / $date_Current_endBlockHeight"
echo "Auction End date based on genesis block... $unix_Current_endBlockHeight / $date_endBlockHeight"
echo ""
