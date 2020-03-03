# set -x # debug

echo 'CBT NodeStart'

# Check for CBT node daemon
gold_main_status=$(ps -ef | grep -w chain=gold_main | grep -v grep | awk '{ print "Online" }')
# echo "$gold_main_status"


if [[ $gold_main_status = "Online" ]] && [[ $ocean_main_status = "Online" ]]
then
	echo "CBT Ocean server online"
else
	$HOME/ocean/oceand -datadir=$HOME/CBT/mainnet/ocean-cb &
	echo "CBT Ocean server starting..."
	echo -e
	sleep 8
fi
