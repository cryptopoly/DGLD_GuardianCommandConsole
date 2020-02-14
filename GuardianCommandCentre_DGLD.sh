clear

# Check for ocean and dgld node daemons
gold_main_status=$(ps -ef | grep -w chain=gold_main | grep -v grep | awk '{ print "DGLD_Online" }')
# echo "$gold_main_status"
ocean_main_status=$(ps -ef | grep -w chain=ocean_main | grep -v grep | awk '{ print "CBT_Online" }')
# echo "$ocean_main_status"


if $gold_main_status = "DGLD_Online" && $ocean_main_status = "CBT_Online";
then
	echo "DGLD and CBT Nodes are running"
else
docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d &
sleep 2
echo ""
fi

RED='\033[0;31m'
AMBER='\033[0;33m'
NC='\033[0m' # No Colour

while true; do
	clear
	echo "Welcome to the DGLD GuardNode Command Centre"
	echo ""

# Current date
echo -n "Date: "
date -u 
echo ""

# GoldNode Sync Status
echo -n "GoldNode Status: "
echo $gold_main_status
if test $gold_main_status > 0 ; 
then
	echo ""
	
	# DGLD.ch explorer blockheight via API
	echo -n "DGLD.ch Blockheight: "
	blockheight_exp=$(curl -s https://explorer.dgld.ch/api/info |\
	jq '.blockheight')
	echo -e $blockheight_exp
	echo ""

# Blockchain sync check from explorer api [+/- block sync tolerance level & pause until sync'd]
if
	[[ $blockheight_node == '' ]]; then blockheight_node=$"0"; fi
while blockheight_node=$(docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getblockcount)
(( $blockheight_node < $blockheight_exp ));
do
	printf "\033[1A"
	printf "\033[5m${AMBER}Node synchronising...$blockheight_node${NC}\033[0m"
	echo ""
done
	printf "\033[1A"
	echo -ne "Local GoldNode Blockheight: "; echo $blockheight_node;
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

