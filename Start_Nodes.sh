#!/bin/bash 
 
# set -x # debug

# Check for dgld and cbt node daemons
gold_main_status=$(ps -efT | grep -w chain=gold_main | grep -v grep | awk '{ print "Online" }')
echo $gold_main_status
ocean_main_status=$(ps -efT | grep -w chain=ocean_main | grep -v grep | awk '{ print "Online" }')
echo "$ocean_main_status"


# MacOS Only
open /Applications/Docker.app &

if [[ $gold_main_status = "Online" ]] && [[ $ocean_main_status = "Online" ]]
then
	# echo "DGLD and CBT Ocean nodes online (docker)"
	sleep 0
else
	echo "DGLD, CBT and GuardNode Ocean docker services starting..."
	# gnome-terminal -- docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up
	# nohup docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up &
	docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up &
	# nohup docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up $HOME/DGLD_GuardianCommandConsole/GuardNodeLogs.txt &
	sleep 4
fi
