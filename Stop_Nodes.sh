#!/bin/bash 
# set -x # debug

# echo "Stopping Docker Nodes"

# Check for dgld and cbt node daemons
gold_main_status=$(ps -ef | grep -w chain=gold_main | grep -v grep | awk '{ print "Online" }')
# echo "$gold_main_status"
ocean_main_status=$(ps -ef | grep -w chain=ocean_main | grep -v grep | awk '{ print "Online" }')
# echo "$ocean_main_status"

if [[ $gold_main_status = "Online" ]] && [[ $ocean_main_status = "Online" ]];
then
	docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean
	docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean-cb
	docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode
	sleep 2
	echo ""
else
	echo -n ""
	# echo "DGLD, CBT GuardNode servers are not currently running (docker)"
fi
