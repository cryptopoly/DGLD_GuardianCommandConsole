# set -x # debug

echo 'DGLD NodeStart'

# Check for dgld node daemon
gold_main_status=$(ps -ef | grep -w chain=gold_main | grep -v grep | awk '{ print "Online" }')
# echo "$gold_main_status"


if [[ $gold_main_status = "Online" ]] && [[ $ocean_main_status = "Online" ]]
then
	echo "DGLD Ocean server online"
else
	$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean &
	echo "DGLD Ocean server starting..."
	echo -e
	sleep 8
fi
