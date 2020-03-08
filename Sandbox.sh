#!/bin/bash 
# jq '.assets,.ref' $HOME/j.json


# jq '.n,.m,.height' $HOME/j.json


# cat $HOME/j.json | grep ref

# jq '.blockNumber' $HOME/peg.json

# cat $HOME/j.json| jq '.assets.headers | [.sender, .to, .subject, ."x-received-time", .received, .from, .date, .id, .to, .subject, .fromfull] + [(.time | tostring)] | join(", ")'

$HOME/DGLD_GuardianCommandConsole/AllNodeStatus.dgld &


echo "DGLD Node Status (docker):"
echo $dgld_main_status

echo "CBT Node Status (docker):"
echo $cbt_main_status

echo "GuardNode Status (docker):"
echo $guardnode_status

echo "DGLD Node Status (binaries):"
echo $bdgld_main_status

echo "CBT Node Status (binaries):"
echo $bcbt_main_status

echo "GuardNode Status (python):"
echo $bguardnode_status

