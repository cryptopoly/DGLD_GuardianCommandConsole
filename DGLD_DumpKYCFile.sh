# set -x # debug

echo 'DGLD Dump KYC File'
$HOME/ocean/oceand -datadir=$HOME/dgld/mainnet/ocean dumpkycfile $HOME/dgld/mainnet/ocean/wallet/kycfile
echo ""	
echo "The KYC File can be found here: /dgld/mainnet/ocean/kycfile"