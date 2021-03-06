#!/bin/bash 

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
# 'b_cc' shortcut to open the command console
# '00' to exit the command console
# 'b_dgld' and 'b_cbt' are shortcuts for RPC call - e.g. getblockchaininfo, getbalance
# 'b_allnodestart' or 'b_allnodestop' to launch/kill all nodes

######### INSTALL_SCRIPT ########

# Log stuff for troubleshooting
# set -x

# Kill docker & binaries processes before install
$HOME/DGLD_GuardianCommandConsole/Stop_Nodes.sh
$HOME/DGLD_GuardianCommandConsole/Stop_Nodes.dgld

# Clear previous aliases
sed -i '/ocean/d' ~/.bash_aliases
sed -i '/dgld/d' ~/.bash_aliases
sed -i '/docker/d' ~/.bash_aliases

# Remove existing $HOME/DGLD_GuardianCommandConsole folder
rm -r -f $HOME/DGLD_GuardianCommandConsole

## Save useful alias shortcuts for node functions ##
# Docker aliases
echo "alias dgld='docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass '" >> ~/.bash_aliases
echo "alias cbt='docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass '" >> ~/.bash_aliases
echo "alias nodestart='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean ocean-cb'" >> ~/.bash_aliases
echo "alias nodestop='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean ocean-cb'" >> ~/.bash_aliases
echo "alias gnstart='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode'" >> ~/.bash_aliases
echo "alias gnstop='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode'" >> ~/.bash_aliases
echo "alias logs='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs'" >> ~/.bash_aliases
echo "alias cc='$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh'" >> ~/.bash_aliases


# Binaries aliases
echo "alias b_dgldnodestart='$HOME/DGLD_GuardianCommandConsole/DGLD_NodeStart.dgld'" >> ~/.bash_aliases
echo "alias b_dgld='$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean '" >> ~/.bash_aliases
echo "alias b_dgldnodestop='$HOME/DGLD_GuardianCommandConsole/DGLD_NodeStop.dgld'" >> ~/.bash_aliases
echo "alias b_cbtnodestart='$HOME/DGLD_GuardianCommandConsole/CBT_NodeStart.dgld'" >> ~/.bash_aliases
echo "alias b_cbt='$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb '" >> ~/.bash_aliases
echo "alias b_cbtnodestop='$HOME/DGLD_GuardianCommandConsole/CBT_NodeStop.dgld'" >> ~/.bash_aliases
echo "alias b_gnstart='$HOME/DGLD_GuardianCommandConsole/GuardNode_NodeStart.dgld'" >> ~/.bash_aliases
echo "alias b_gnstop='$HOME/DGLD_GuardianCommandConsole/GuardNode_NodeStop.dgld'" >> ~/.bash_aliases
echo "alias b_allnodestart='$HOME/DGLD_GuardianCommandConsole/Start_Nodes.dgld'" >> ~/.bash_aliases
echo "alias b_allnodestop='$HOME/DGLD_GuardianCommandConsole/Stop_Nodes.dgld'" >> ~/.bash_aliases
echo "alias b_cc='$HOME/DGLD_GuardianCommandConsole/DGLD_CBT_GuardianCommandConsole.dgld'" >> ~/.bash_aliases

# Force alias update
source ~/.bash_aliases	


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

# Add whitelist to conf
# echo "pkwhitelist=1" >> ~$HOME/dgld/mainnet/ocean/

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

$b_cc
