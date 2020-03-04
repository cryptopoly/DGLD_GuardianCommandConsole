# set -x # debug

# script Log.txt

## Declare environment variables ##
export b_dgldnodestart="$HOME/DGLD_GuardianCommandConsole/DGLD_NodeStart.dgld"
export b_dgld="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean "
export b_dgldnodestop="$HOME/DGLD_GuardianCommandConsole/DGLD_NodeStop.dgld"
export b_cbtnodestart="$HOME/DGLD_GuardianCommandConsole/CBT_NodeStart.dgld"
export b_cbt="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb "
export b_cbtnodestop="$HOME/DGLD_GuardianCommandConsole/CBT_NodeStop.dgld"
export b_gnstart="$HOME/DGLD_GuardianCommandConsole/GuardNode_NodeStart.dgld"
export b_gnstop="$HOME/DGLD_GuardianCommandConsole/GuardNode_NodeStop.dgld"
export b_allnodestart="$HOME/DGLD_GuardianCommandConsole/Start_Nodes.dgld"
export b_allnodestop="$HOME/DGLD_GuardianCommandConsole/Stop_Nodes.dgld"
export b_cc="$HOME/DGLD_GuardianCommandConsole/DGLD_CBT_GuardianCommandConsole.dgld"

# Text colouring
RED='\033[0;31m'
AMBER='\033[0;33m'
NC='\033[0m' # No Colour

# Kill docker processes before running binaries command console
docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode ocean ocean-cb
pids=$(pgrep docker);sudo kill $pids &
sleep 2

## Start DGLD, CBT and GuardNode nodes ##
cd $HOME/DGLD_GuardianCommandConsole
# $HOME/DGLD_GuardianCommandConsole/Start_Nodes.dgld


# Loop CC
while true; do
clear
echo "Welcome to the DGLD-CBT GuardNode Command Console - Binaries Edition"
# Current date
echo -n "Date: "
date -u 
echo ""

# Check for dgld and cbt node daemons
dgld_main_status=$(ps -aux | grep -w "ocean" | grep -v "ocean-cb" | grep -v guardnode | grep -v grep | awk '{ print "Online" }')
# echo "$dgld_main_status"
cbt_main_status=$(ps -aux | grep -w "ocean-cb" | grep -v grep | awk '{ print "Online" }')
# echo "$cbt_main_status"

# DGLD Sync Status
echo -n "DGLD Node Status: "
# echo $dgld_main_status
if test $dgld_main_status = "Online" ; 
then
	# DGLD explorer blockheight via API
	echo -n "DGLD Explorer Blockheight: "
	dgld_blockheight_exp=$(curl -s https://explorer.dgld.ch/api/info |\
	jq '.blockheight')
	echo -e $dgld_blockheight_exp
	echo ""
	# DGLD node sync check from explorer api [+/- block sync tolerance level & pause until sync'd]
	if
		[[ $dgld_blockheight_node == '' ]]; then dgld_blockheight_node=$"0"; fi
	while dgld_blockheight_node=$($HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean getblockcount)
	(( $dgld_blockheight_node < $dgld_blockheight_exp ));
	do
		printf "\033[1A"
		printf "\033[5m${AMBER}Node synchronising...$dgld_blockheight_node${NC}\033[0m"
		echo ""
	done
		printf "\033[1A"
		echo -ne "Local DGLD Node Blockheight: "; echo $dgld_blockheight_node;
	else printf "${RED}Node not running${NC}"
		echo ""
	fi
	echo ""

# CBT Sync Status
echo -n "CBT Node Status: "
# echo $cbt_main_status
if test $cbt_main_status = "Online" ; 
then
	# CBT explorer blockheight via API
	echo -n "CBT Explorer Blockheight: "
	cbt_blockheight_exp=$(curl -s https://cbtexplorer.com/api/info |\
	jq '.blockheight')
	echo -e $cbt_blockheight_exp
	echo ""
	# CBT node sync check from explorer api [+/- block sync tolerance level & pause until sync'd]
	if
		[[ $cbt_blockheight_node == '' ]]; then cbt_blockheight_node=$"0"; fi
	while cbt_blockheight_node=$($HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb getblockcount)
	(( $cbt_blockheight_node < $cbt_blockheight_exp ));
	do
		printf "\033[1A"
		printf "\033[5m${AMBER}Node synchronising...$cbt_blockheight_node${NC}\033[0m"
		echo ""
	done
		printf "\033[1A"
		echo -ne "Local CBT Node Blockheight: "; echo $cbt_blockheight_node;
	else printf "${RED}Node not running${NC}"; echo ""
		echo ""
	fi
	echo ""


# Show Menu
echo ""
menu=$(ls -lh *.dgld | awk '{ print ++lvalue, $9 }')
menucount=$(echo "$menu"|wc -l)
echo "$menu"
echo ""

# Menu ID Entry
echo "Choose an option between 1 and "$menucount" and press enter:"
read menuid
echo ""
echo ""

# Exit clause
if [[ -z $menuid ]] ; then exec
elif [[ $menuid == "00" ]] ; then exit ; echo "Exiting DGLD Guardian Command Console"; echo ""; exit
elif ! (($menuid >= 1 && $menuid <= $menucount)) ; then exec
else

# Execute command file
exec=$(echo "$menu" | grep -w "$menuid" | awk '{ print $2 }')
./"$exec"
echo ""


# Confirm exit command
read -n 1 -s -r -p "Press any key to continue"
echo ""
echo ""

fi
done
