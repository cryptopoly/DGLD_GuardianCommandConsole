#### DGLD CBT Ocean Nodes and GuardNode kinda all-in-one script ####

######## WARNING: USE AT YOUR OWN RISK - I HAVE NO IDEA WHAT I'M DOING! ########

# CryptoRaptor
# https://twitter.com/cryptopoly

# Semi-Pros
# Git clone this repo and execute this file if you're in the know. If the previous sentence is jibberish check out the easy steps :D

# Noobs
# Step 1 - Open terminal
# Step 2 - Enter 'sudo apt install curl'
# Step 3 - Enter password
# Step 4 - Press 'y'
# Step 5 - Enter 'curl -Ls https://raw.githubusercontent.com/cryptopoly/DGLD_GuardianCommandConsole/master/README.sh | bash'
# Step 6 - Restart the VPS once all installed to ensure settings are fully applied

# TERMINAL SHORTCUTS/COMMANDS:
# 'cc' shortcut to open the command console
# '00' to exit the command console
# 'dgld' and 'cbt' are shortcuts for RPC call - e.g. getblockchaininfo, getbalance
# 'nodestart' or 'nodestop' to launch/kill both nodes

######### INSTALL_SCRIPT ########

# Log stuff for troubleshooting
set -x

## Save useful alias shortcuts for node functions ##
echo "alias dgld='docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass '" >> ~/.bash_aliases
echo "alias cbt='docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass '" >> ~/.bash_aliases
echo "alias nodestart='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean ocean-cb'" >> ~/.bash_aliases
echo "alias nodestop='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean ocean-cb'" >> ~/.bash_aliases
echo "alias gnstart='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode'" >> ~/.bash_aliases
echo "alias gnstop='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode'" >> ~/.bash_aliases
echo "alias logs='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs'" >> ~/.bash_aliases
echo "alias cc='$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh'" >> ~/.bash_aliases
source ~/.bash_aliases

## Declare environment variables ##
dgldnodestart="./ocean/oceand -datadir=$HOME/dgld/mainnet/ocean"
dgld="./ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean "
dgldnodestop="./ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean stop"

cbtnodestart="./ocean/oceand -datadir=$HOME/dgld/mainnet/ocean"
cbt="./ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb "
cbtnodestop="./ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb stop"

gnstart="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode"
gnstop="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode"
logs="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs"
cc="$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh"


# Install GuardNode
cd $HOME
git clone https://github.com/commerceblock/guardnode
cd guardnode
sudo pip3 install -r requirements.txt
sudo python3 setup.py build
sudo python3 setup.py install


# Install required libraries
cd $HOME
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install git -y
git clone https://github.com/goldtokensa/config dgld
git clone https://github.com/cryptopoly/DGLD_GuardianCommandConsole
sudo apt install jq -y
sudo apt install curl -y
sudo apt autoremove -y

# Create folders
mkdir $HOME/ocean
mkdir $HOME/ocean/binaries
mkdir $HOME/ocean/binaries/versions

# Get latest deb release version & URL from github
LATEST_RELEASE=$(curl -s https://api.github.com/repos/commerceblock/ocean/releases/latest \
| grep "tag_name" \
| awk '{print substr($2, 2, length($2)-3) }')
URL=(https://github.com/commerceblock/ocean/releases/download/$LATEST_RELEASE/ocean-$LATEST_RELEASE.deb)

# Create version folder and download deb
mkdir $HOME/ocean/binaries/versions/$LATEST_RELEASE

# Download .deb binaries
curl -L -o $HOME/ocean/versions/$LATEST_RELEASE/$LATEST_RELEASE.deb $URL

# Unpack binaries
dpkg-deb -R $HOME/$LATEST_RELEASE.deb $HOME/ocean/binaries/versions/$LATEST_RELEASE/

# Find and copy binaries
find $HOME/ocean/binaries/versions/$LATEST_RELEASE -name "*ocean*" -type f -exec cp {} $HOME/ocean/ \;


# Update Docker premissions to docker without mod
sudo usermod -aG docker $USER
source ~/.bash_aliases

# Add double-click to run in terminal
gsettings set org.gnome.nautilus.preferences executable-text-activation ask

# Start dgld & cbt nodes
cd $HOME/dgld
sudo docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean ocean-cb
sleep 4
$dgld getblockchaininfo
$cbt getblockchaininfo

# Start guardnode
sudo docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode
sleep 4
$logs guardnode

# Confirm exit command
read -n 1 -s -r -p "Press any key to restart"
echo ""
echo ""

shutdown -r
