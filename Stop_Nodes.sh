 
# set -x # debug

echo "DGLD and CBT Ocean servers starting..."
echo ""

# Start dgld & cbt nodes
$dgld stop &
sleep 2
$cbt stop &
sleep 2

# Start guardnode
$gnstop &
sleep 2
