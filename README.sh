#### DGLD CBT Ocean Nodes and GuardNode kinda all-in-one script ####

######## WARNING: USE AT YOUR OWN RISK - I HAVE NO IDEA WHAT I'M DOING! ########

# CryptoRaptor
# https://twitter.com/cryptopoly

# Semi-Pros
# Git clone this repo and execute this file if you're in the know. If the previous sentence is jibberish check out the easy steps :D

# Noobs
# Step 1 - Open terminal
# Step 2 - Enter 'sudo apt install git'
# Step 3 - Enter password
# Step 4 - Press 'y'
# Step 5 - Enter 'curl -Ls https://raw.githubusercontent.com/cryptopoly/DGLD_GuardianCommandConsole/master/README.sh | bash'
# Step 6 - Restart once all installed to ensure settings are fully applied

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
dgld="docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass "
cbt="docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass "
nodestart="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean ocean-cb"
nodestop="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean ocean-cb"
gnstart="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode"
gnstop="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode"
logs="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs"
cc="$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh"

## Declare environment variables ##
# $HOME/DGLD_GuardianCommandConsole/Variables.sh

# Install required libraries
cd $HOME
sudo apt install git -y
sudo apt-get update -y
git clone https://github.com/goldtokensa/config dgld
git clone https://github.com/cryptopoly/DGLD_GuardianCommandConsole
sudo apt install docker -y
sudo apt install docker-compose -y
sudo apt install jq -y
sudo apt install curl -y
sudo apt autoremove -y

# Update Docker premissions to docker without mod
sudo usermod -aG docker $USER
source ~/.bash_aliases

# Add double-click to run in terminal
gsettings set org.gnome.nautilus.preferences executable-text-activation ask

# Start dgld & cbt nodes
cd $HOME/dgld
$nodestart
sleep 2
$dgld getblockchaininfo
$cbt getblockchaininfo

# Start guardnode
$gnstart
$logs guardnode

# Confirm exit command
read -n 1 -s -r -p "Press any key to restart"
echo ""
echo ""

shutdown -r
