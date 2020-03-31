#!/bin/bash 

# Clear aliases
grep -v "" ~/.bash_aliases > ~/.bash_aliases

## Save useful alias shortcuts for node functions ##

# Binaries aliases
echo "alias dgldnodestart='$HOME/DGLD_GuardianCommandConsole/DGLD_NodeStart.dgld'" >> ~/.bash_aliases
echo "alias dgld='$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean '" >> ~/.bash_aliases
echo "alias dgldnodestop='$HOME/DGLD_GuardianCommandConsole/DGLD_NodeStop.dgld'" >> ~/.bash_aliases
echo "alias cbtnodestart='$HOME/DGLD_GuardianCommandConsole/CBT_NodeStart.dgld'" >> ~/.bash_aliases
echo "alias cbt='$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb '" >> ~/.bash_aliases
echo "alias cbtnodestop='$HOME/DGLD_GuardianCommandConsole/CBT_NodeStop.dgld'" >> ~/.bash_aliases
echo "alias gnstart='$HOME/DGLD_GuardianCommandConsole/GuardNode_NodeStart.dgld'" >> ~/.bash_aliases
echo "alias gnstop='$HOME/DGLD_GuardianCommandConsole/GuardNode_NodeStop.dgld'" >> ~/.bash_aliases
echo "alias allnodestart='$HOME/DGLD_GuardianCommandConsole/Start_Nodes.dgld'" >> ~/.bash_aliases
echo "alias allnodestop='$HOME/DGLD_GuardianCommandConsole/Stop_Nodes.dgld'" >> ~/.bash_aliases
echo "alias cc='$HOME/DGLD_GuardianCommandConsole/DGLD_CBT_GuardianCommandConsole.sh'" >> ~/.bash_aliases

# Docker aliases
# echo "alias dgld='docker exec guardnode_ocean_1 ocean-cli -rpcport=8443 -rpcuser=ocean -rpcpassword=oceanpass '" >> ~/.bash_aliases
# echo "alias cbt='docker exec guardnode_ocean-cb_1 ocean-cli -rpcport=8332 -rpcuser=ocean -rpcpassword=oceanpass '" >> ~/.bash_aliases
# echo "alias nodestart='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean ocean-cb'" >> ~/.bash_aliases
# echo "alias nodestop='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean ocean-cb'" >> ~/.bash_aliases
# echo "alias gnstart='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode'" >> ~/.bash_aliases
# echo "alias gnstop='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode'" >> ~/.bash_aliases
# echo "alias logs='docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs'" >> ~/.bash_aliases
# echo "alias cc='$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh'" >> ~/.bash_aliases

# Force alias update
source ~/.bash_aliases

# ## Declare environment variables ##
# export bdgldnodestart="$HOME/DGLD_GuardianCommandConsole/DGLD_NodeStart.dgld"
# export bdgld="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean "
# export bdgldnodestop="$HOME/DGLD_GuardianCommandConsole/DGLD_NodeStop.dgld"
# export bcbtnodestart="$HOME/DGLD_GuardianCommandConsole/CBT_NodeStart.dgld"
# export bcbt="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb "
# export bcbtnodestop="$HOME/DGLD_GuardianCommandConsole/CBT_NodeStop.dgld"
# export bgnstart="$HOME/DGLD_GuardianCommandConsole/GuardNode_NodeStart.dgld"
# export bgnstop="$HOME/DGLD_GuardianCommandConsole/GuardNode_NodeStop.dgld"
# export ballnodestart="$HOME/DGLD_GuardianCommandConsole/Start_Nodes.dgld"
# export ballnodestop="$HOME/DGLD_GuardianCommandConsole/Stop_Nodes.dgld"
# export bcc="$HOME/DGLD_GuardianCommandConsole/DGLD_CBT_GuardianCommandConsole.dgld"

