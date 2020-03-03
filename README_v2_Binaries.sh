#### DGLD CBT Ocean Nodes and GuardNode kinda all-in-one script ####

######## WARNING: USE AT YOUR OWN RISK - I HAVE NO IDEA WHAT I'M DOING! ########

# CryptoRaptor
# https://twitter.com/cryptopoly

# Semi-Pros
# Git clone this repo and execute this file if you're in the know. If the previous sentence is jibberish check out the easy steps :D

# Noobs
# Step 1 - Open terminal
# Step 2 - Enter 'sudo apt install curl -y; curl -Ls https://raw.githubusercontent.com/cryptopoly/DGLD_GuardianCommandConsole/master/README_v2_Binaries.sh | bash'
# Step 3 - Enter password
# Step 4 - Enter 'y'
# Step 5 - Restart the VPS once all installed to ensure settings are fully applied

# TERMINAL SHORTCUTS/COMMANDS:
# 'cc' shortcut to open the command console
# '00' to exit the command console
# 'dgld' and 'cbt' are shortcuts for RPC call - e.g. getblockchaininfo, getbalance
# 'nodestart' or 'nodestop' to launch/kill both nodes

######### INSTALL_SCRIPT ########

# Log stuff for troubleshooting
set -x

## Save useful alias shortcuts for node functions ##
echo "alias dgldnodestart='$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean'" >> ~/.bash_aliases
echo "alias dgld='$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean '" >> ~/.bash_aliases
echo "alias dgldnodestop='$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean stop'" >> ~/.bash_aliases
echo "alias cbtnodestart='$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean-cb'" >> ~/.bash_aliases
echo "alias cbt='$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb '" >> ~/.bash_aliases
echo "alias cbtnodestop='$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb stop'" >> ~/.bash_aliases
echo "alias gnstart='$HOME/guardnode/run_guardnode --rpcuser ocean --rpcpass oceanpass --rpchost 0.0.0.0:8443 --servicerpcuser ocean --servicerpcpass oceanpass --servicerpchost 127.0.0.1:8332 --nodelogfile $HOME/dgld/mainnet/ocean/gold_main/debug.log --challengehost https://coordinator.mainnet.gtsa.io:10007 --bidlimit 1'" >> ~/.bash_aliases
# echo "alias gnstop='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode'" >> ~/.bash_aliases
# echo "alias logs='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs'" >> ~/.bash_aliases

echo "alias cc='$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh'" >> ~/.bash_aliases

## Force alias refresh
source ~/.bash_aliases

## Declare environment variables ##
dgldnodestart="$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean"
dgld="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean "
dgldnodestop="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean stop"
cbtnodestart="$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean-cb"
cbt="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb "
cbtnodestop="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb stop"
gnstart="$HOME/guardnode/run_guardnode --rpcuser ocean --rpcpass oceanpass --rpchost 0.0.0.0:8443 --servicerpcuser ocean --servicerpcpass oceanpass --servicerpchost 127.0.0.1:8332 --nodelogfile $HOME/dgld/mainnet/ocean/gold_main/debug.log --challengehost https://coordinator.mainnet.gtsa.io:10007 --bidlimit 1"
# gnstop="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode"
# logs="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs"

cc="$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh"

# Install required libraries
cd $HOME
# sudo apt-get update -y
# sudo apt-get upgrade -y
sudo apt install git -y
git clone https://github.com/goldtokensa/config dgld
git clone https://github.com/cryptopoly/DGLD_GuardianCommandConsole
sudo apt install jq -y
sudo apt install curl -y
# sudo apt autoremove -y

# Create folders
mkdir $HOME/ocean
mkdir $HOME/ocean/binaries
mkdir $HOME/ocean/binaries/versions

# Get latest deb release version & URL from github
LATEST_RELEASE=$(curl -s https://api.github.com/repos/commerceblock/ocean/releases/latest \
| grep "tag_name" \
| awk '{print substr($2, 2, length($2)-3) }')
URL=(https://github.com/commerceblock/ocean/releases/download/$LATEST_RELEASE/ocean-$LATEST_RELEASE.deb)

echo $LATEST_RELEASE
echo $URL

# Create version folder and download deb
mkdir $HOME/ocean/binaries/$LATEST_RELEASE

# Download .deb binaries
curl -L -o $HOME/ocean/binaries/$LATEST_RELEASE/$LATEST_RELEASE.deb $URL

# Unpack binaries
dpkg-deb -R $HOME/ocean/binaries/$LATEST_RELEASE/$LATEST_RELEASE.deb $HOME/ocean/binaries/$LATEST_RELEASE/

# Find and copy binaries
find $HOME/ocean/binaries/$LATEST_RELEASE -name "*ocean*" -type f -exec cp {} $HOME/ocean/ \;

# Clean up
rm -r $HOME/ocean/binaries/$LATEST_RELEASE/usr
rm -r $HOME/ocean/binaries/$LATEST_RELEASE/DEBIAN

# Install GuardNode
cd $HOME
git clone https://github.com/commerceblock/guardnode
cd guardnode
sudo apt install python3-pip -y
sudo pip3 install -r requirements.txt
sudo python3 setup.py build
sudo python3 setup.py install

# Add double-click to run in terminal
gsettings set org.gnome.nautilus.preferences executable-text-activation ask

# Start dgld & cbt nodes
$dgldnodestart &
sleep 3
$cbtnodestart &
sleep 4
$dgld getblockchaininfo
$cbt getblockchaininfo

# Start guardnode
$gnstart
sleep 2

# Confirm exit command
read -n 1 -s -r -p "Press any key to continue to the DGLD_GuardianCommandConsole"
echo ""
echo ""

$cc
