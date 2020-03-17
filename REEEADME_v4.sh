#!/bin/bash 

#### DGLD CBT Ocean Nodes and GuardNode kinda all-in-one script ####


######## WARNING: USE AT YOUR OWN RISK - I HAVE NO IDEA WHAT I'M DOING! ########


# CryptoRaptor
# https://twitter.com/cryptopoly

# Semi-Pros
# Git clone this repo and execute this file if you're in the know. If the previous sentence is jibberish check out the easy steps :D

# Noobs
# Step 1 - Open terminal
# Step 2 - Enter 'sudo apt install curl -y; curl -Ls https://raw.githubusercontent.com/cryptopoly/DGLD_GuardianCommandConsole/master/REEEADME_v4.sh | bash'
# Step 3 - Enter password
# Step 4 - Enter 'y'
# Step 5 - Restart the VPS once all installed to ensure settings are fully applied

# TERMINAL SHORTCUTS/COMMANDS:
# 'cc' shortcut to open the command console
# '00' to exit the command console
# 'dgld' and 'cbt' are shortcuts for RPC call - e.g. getblockchaininfo, getbalance
# 'allnodestart' or 'allnodestop' to launch/kill all nodes
# 'b' prefix to all shortcuts to run the binaries version

######### INSTALL_SCRIPT ########

# Log stuff for troubleshooting
# set -x

# MacOS requirements
# brew update && brew upgrade
# brew uninstall --ignore-dependencies openssl; brew install https://github.com/tebelorg/Tump/releases/download/v1.0.0/openssl.rb
# brew reinstall python
# brew install dpkg #For debian package uninstall
# brew install -d -o $(whoami) -g admin /usr/local/Frameworks #Python link fix
# chmod a+x ./bclock #Fix permissions for MacOS ?
# brew update && brew upgrade
# brew uninstall openssl; brew install https://github.com/tebelorg/Tump/releases/download/v1.0.0/openssl.rb
# brew reinstall openssl
# brew uninstall libjson-rpc-cpp
# brew install -s libjson-rpc-cpp
# Shallow brew fix
# git -C "$(brew --repo homebrew/core)" fetch --unshallow

# Kill docker & binaries processes before install
cd $HOME/DGLD_GuardianCommandConsole/
killall oceand
killall guardnode
killall docker

# Latest Aliases
./AliasUpdate.sh &

# Force alias update
source ~/.bash_aliases

# Install required libraries
cd $HOME/DGLD_GuardianCommandConsole/
sudo apt-get update -y
apt-get upgrade -y
apt dist-upgrade -y
apt install git -y
git clone https://github.com/goldtokensa/config dgld
git clone https://github.com/cryptopoly/DGLD_GuardianCommandConsole
apt install docker -y
apt install docker-compose -y
apt install jq -y
apt install curl -y
apt autoremove -y

# Install Cask (MacOS specific)
# Install Cask
# brew install caskroom/cask/brew-cask
# # Install docker toolbox
# brew cask install docker-toolbox
# # Install client binaries on macOS
# tar xzvf $HOME/Downloads/docker-19.03.1.tgz

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
apt install python3-pip -y
pip3 install -r requirements.txt
python3 setup.py build
python3 setup.py install

# Update permissions docker permissions and launch
# usermod -aG docker $USER
# docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean
# docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean-cb
# docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode
# sleep 4

# Install cb tools (inc token report)
# sudo pip3 install python-bitcoinlib
# sudo pip3 install python-bitcoinlib


# Import fees address
$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean &
$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean-cb &
$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean importaddress gLMjotKMMTni8GaTddRdxydZ3p5SRJcjFq &





echo "System restarting to apply changes"
sleep 4
shutdown -r 0
