#!/bin/bash 
# set -x # debug

# ---PreReqs---
1. Install Node.js
https://nodejs.org/en/download/
2. Install mongodb Community Edition
https://docs.mongodb.com/manual/installation/
3. Create MongoDB Folders
cd $HOME
mkdir mongodb
4. git clone https://github.com/commerceblock/ocean-explorer


# ---BASH RC environment variables (need each time)---
export DB_USER=myTester
export DB_PASSWORD=ypdt6pnLnkd7
export DB_HOST=127.0.0.1
export DB_PORT=27017
export DB_NAME=test
export RPC_USER=ocean
export RPC_PASSWORD=oceanpass
export OCEAN_HOST=0.0.0.0
export OCEAN_PORT=8443
export GENESIS_ASSET=c66cb6eb7cd585788b294be28c8dcd6be4e37a0a6d238236b11c0beb25833bb9


# Start mongo daemon
sudo cd #force login
sudo mongod --port 27017 --dbpath /Users/cryptopoly/mongodb &
sleep 2

# Start ocean-explorer
cd $HOME/ocean-explorer
npm start &
sleep 2

# Start 
while true; do
cd $HOME/ocean-explorer/scripts
node dbbuilder.js update 
sleep 50
done



# ---References---

# Navigate here for the explorer
# 127.0.0.1:3002

# ---MongoDB Ocean Tables---
# addrtxes
# assets
# balances
# blocks
# infos
# pegouts
# txes

# ---Export tables from mongodb---
# mongoexport -d test -c balances -o addrtxes --jsonArray
# mongoexport -d test -c balances -o assets --jsonArray
# mongoexport -d test -c balances -o balances --jsonArray
# mongoexport -d test -c balances -o blocks --jsonArray
# mongoexport -d test -c balances -o infos --jsonArray
# mongoexport -d test -c balances -o pegouts --jsonArray
# mongoexport -d test -c balances -o txes --jsonArray