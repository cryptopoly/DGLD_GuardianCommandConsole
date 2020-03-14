#!/bin/bash 

# Mongodb for cbt explorer
brew tap mongodb/brew
brew install mongodb-community@4.2
brew install npm
git clone https://github.com/commerceblock/ocean-explorer
cd ocean-explorer
npm install
npm audit fix

# Start mongodb
brew services start mongodb-community@4.2

