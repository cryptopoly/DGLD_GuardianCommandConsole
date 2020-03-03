 
# set -x # debug

echo "DGLD, CBT & GuardNode servers starting..."
echo ""

# Start dgld & cbt nodes
$dgldnodestart &
sleep 3
$cbtnodestart &
sleep 4
$dgld getblockchaininfo
$cbt getblockchaininfo

# Start guardnode
$gnstart &
sleep 2
