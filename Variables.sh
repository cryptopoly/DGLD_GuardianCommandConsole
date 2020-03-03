## Declare environment variables ##
export dgld="$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean "
export cbt="$HOME/ocean/ocean-cli -datadir=$HOME/dgld/mainnet/ocean-cb "
export nodestart="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d ocean ocean-cb"
export nodestop="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop ocean ocean-cb"
export gnstart="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml up -d guardnode"
export gnstop="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml stop guardnode"
export logs="docker-compose -f $HOME/dgld/mainnet/docker/guardnode/docker-compose.yml logs"
export cc="$HOME/DGLD_GuardianCommandConsole/GuardianCommandConsole_DGLD_CBT.sh"
