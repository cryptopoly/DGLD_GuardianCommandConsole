# DGLD_GuardianCommandConsole
DGLD-CBT GuardNode Command Console

Docker version will be retired eventually. Binaries better (and soon choice to self compile code). Both can be installed simultaneously but can only run one at a time. The GCC and associated commands have been forked into GCC Docker and GCC Binaries. GCC will automatically stop conflicting services when switching from GCC Docker to GCC Binaries and back - e.g. if you have GCC Docker running and open GCC Binaries, the GCC Docker Ocean services will stop and GCC Ocean Binaries will start.



# Docker Version (v1)
See README_v1_Docker.sh for instructions (or just copy and paste the below into a fresh linux vm (anything 18.04 and up))

sudo apt install curl -y; curl -Ls https://raw.githubusercontent.com/cryptopoly/DGLD_GuardianCommandConsole/master/README_v2_Docker.sh | bash


# Binaries Version (v1)
See README_v2_Binaries.dgld for instructions (or just copy and paste the below into a fresh linux vm (anything 18.04 and up))

sudo apt install curl -y; curl -Ls https://raw.githubusercontent.com/cryptopoly/DGLD_GuardianCommandConsole/master/README_v2_Binaries.sh | bash
