 

#### DGLD CBT Ocean Nodes and GuardNode kinda all-in-one script ####

# CryptoRaptor Represent
# https://twitter.com/cryptopoly

# Semi-Pros
# Git clone this repo and execute this file if you're in the know. If the previous sentence is jibberish check out the easy steps :D

# Noobs
# Step 1 - Open terminal
# Step 2 - Type 'nano cbt.sh' and press Enter [nano text editor appears]
# Step 3 - Copy below script into nano
# Step 4 - Press Ctrl+x
# Step 5 - Type 'y'
# Step 6 - Press Enter to save
# Step 7 - Type 'chmod +x cbt.sh' and press Enter
# Step 8 - Type './cbt.sh' and press Enter
# Step 9 - Type 'sudo -s', press Enter and type your password
# Step 10 - Restart once all installed




# TERMINAL SHORTCUTS/COMMANDS:
# 'cc' shortcut to open the command centre
# '00' to exit the command centre
# 'dgld' and 'cbt' are shortcuts for RPC call - e.g. getblockchaininfo, getbalance
# 'nodestart' or 'nodestop' to launch/kill both nodes



######### INSTALL_SCRIPT ########

# Log stuff for troubleshooting
set -x

## Save useful shortcuts for node functions ##
echo "alias dgld='docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass '" >> ~/.bash_aliases
echo "alias cbt='docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass '" >> ~/.bash_aliases
echo "alias nodestart='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d'" >> ~/.bash_aliases
echo "alias nodestop='killall oceand'" >> ~/.bash_aliases
echo "alias cc='$HOME/DGLD_GuardianCommandCentre/GuardianCommandCentre_DGLD_CBT.sh'" >> ~/.bash_aliases
source ~/.bash_aliases

# Install required libraries/functions
cd
sudo apt install git -y
git clone https://github.com/goldtokensa/config dgld
git clone https://github.com/cryptopoly/DGLD_GuardianCommandCentre
sudo apt install docker -y
sudo apt install docker-compose -y
sudo apt install jq -y
sudo apt install curl -y
sudo apt autoremove -y

# Install GuardNode
cd $HOME
git clone https://github.com/commerceblock/guardnode
cd guardnode
sudo pip3 install -r requirements.txt
sudo python3 setup.py build
sudo python3 setup.py install

# Update Docker premissions to docker without mod
sudo usermod -aG docker $USER
source ~/.bash_aliases

# Add double-click to run in terminal
gsettings set org.gnome.nautilus.preferences executable-text-activation ask


# Run Stuff
cd $HOME/dgld
sudo docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d
sleep 2
sudo docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass getblockchaininfo
sudo docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass getblockchaininfo

# Confirm exit command
read -n 1 -s -r -p "Press any key to restart"
echo ""
echo ""

shutdown -r
