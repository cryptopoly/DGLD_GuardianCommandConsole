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
# Step 6 - Restart once all installed to ensure settings are fully applied

# TERMINAL SHORTCUTS/COMMANDS:
# 'cc' shortcut to open the command console
# '00' to exit the command console
# 'dgld' and 'cbt' are shortcuts for RPC call - e.g. getblockchaininfo, getbalance
# 'nodestart' or 'nodestop' to launch/kill both nodes

######### INSTALL_SCRIPT ########

# Log stuff for troubleshooting
# set -x

# Stop/kill all related processes before install
pids=$(pgrep docker);sudo kill $pids &
killall oceand &

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
export dgld="docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass "
export cbt="docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass "
export nodestart="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean ocean-cb"
export nodestop="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean ocean-cb"
export gnstart="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode"
export gnstop="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode"
export logs="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs"
export cc="$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh"



docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode
docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean ocean-cb guardnode
pids=$(pgrep docker);sudo kill $pids &
killall oceand &
killall guardnode &

## Declare environment variables ##
# $HOME/DGLD_GuardianCommandConsole/Variables.sh

# Install required libraries
cd $HOME
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
