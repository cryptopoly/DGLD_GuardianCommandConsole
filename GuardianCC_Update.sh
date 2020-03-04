 # set -x # debug

# Kill any related processes before update
killall oceand &
killall python3 &
killall docker &

cd $HOME/DGLD_GuardianCommandConsole
git pull origin master
