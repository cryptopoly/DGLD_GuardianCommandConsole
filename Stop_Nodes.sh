 # set -x # debug

# Check for dgld and cbt node daemons
gold_main_status=$(ps -ef | grep -w chain=gold_main | grep -v grep | awk '{ print "Online" }')
# echo "$gold_main_status"
ocean_main_status=$(ps -ef | grep -w chain=ocean_main | grep -v grep | awk '{ print "Online" }')
# echo "$ocean_main_status"

if [[ $gold_main_status = "Online" ]] && [[ $ocean_main_status = "Online" ]]
then
	killall oceand
	echo "DGLD and CBT Ocean servers stopping"
	sleep 2
else
	echo "DGLD and CBT Ocean servers are not currently running"

fi
