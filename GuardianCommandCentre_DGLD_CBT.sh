# set -x # debug

clear
cd $HOME/DGLD_GuardianCommandCentre
./Start_Nodes.sh
# ./DGLD_Start_DGLD_Node.sh

RED='\033[0;31m'
AMBER='\033[0;33m'
NC='\033[0m' # No Colour



while true; do
clear
echo "Welcome to the DGLD-CBT GuardNode Command Centre"
# Current date
echo -n "Date: "
date -u 
echo ""


# Check for dgld and cbt node daemons
gold_main_status=$(ps -ef | grep -w chain=gold_main | grep -v grep | awk '{ print "Online" }')
# echo "$gold_main_status"
ocean_main_status=$(ps -ef | grep -w chain=ocean_main | grep -v grep | awk '{ print "Online" }')
# echo "$ocean_main_status"



# DGLD Sync Status
echo -n "Gold Node Status: "
echo $gold_main_status
if test $gold_main_status > 0 ; 
then
	
	# DGLD.ch explorer blockheight via API
	echo -n "DGLD.ch Blockheight: "
	gold_blockheight_exp=$(curl -s https://explorer.dgld.ch/api/info |\
	jq '.blockheight')
	echo -e $gold_blockheight_exp
	echo ""



# Gold node sync check from explorer api [+/- block sync tolerance level & pause until sync'd]
if
	[[ $gold_blockheight_node == '' ]]; then gold_blockheight_node=$"0"; fi
while gold_blockheight_node=$(docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getblockcount)
(( $gold_blockheight_node < $gold_blockheight_exp ));
do
	printf "\033[1A"
	printf "\033[5m${AMBER}Node synchronising...$gold_blockheight_node${NC}\033[0m"
	echo ""
done
	printf "\033[1A"
	echo -ne "Local GoldNode Blockheight: "; echo $gold_blockheight_node; echo ""
else printf "${RED}Node not running${NC}"; echo ""
fi


# CBT Sync Status
echo -n "CBT Node Status: "
echo $ocean_main_status
if test $ocean_main_status > 0 ; 
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
while cbt_blockheight_node=$(docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getblockcount)
(( $cbt_blockheight_node < $cbt_blockheight_exp ));
do
	printf "\033[1A"
	printf "\033[5m${AMBER}Node synchronising...$cbt_blockheight_node${NC}\033[0m"
	echo ""
done
	printf "\033[1A"
	echo -ne "Local CBT Node Blockheight: "; echo $cbt_blockheight_node;
else printf "${RED}Node not running${NC}"; echo ""
fi



# Show Menu
echo ""
menu=$(ls -lh *.sh | awk '{ print ++lvalue, $9 }')
menucount=$(echo "$menu"|wc -l)
echo "$menu"
echo ""

# Menu ID Entry
echo "Choose an option between 1 and "$menucount" and press enter:"
read menuid
echo ""

# Exit clause
if [[ -z $menuid ]] ; then exec
elif [[ $menuid == "00" ]] ; then exit ; echo "Exiting DGLD Guardian Command Centre"; echo ""; exit
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

