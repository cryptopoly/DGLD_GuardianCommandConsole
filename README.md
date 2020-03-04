# DGLD_GuardianCommandConsole
DGLD-CBT GuardNode Command Console

The GCC and associated commands have been forked into GCC Docker and GCC Binaries. Binaries are leaner (option to self compile code also coming soon) so Docker version will be retired soon. Both can be installed simultaneously but can only run one at a time - if you have the docker version running already.

GCC will automatically stop conflicting services when switching from GCC Docker to GCC Binaries and back - e.g. if you have GCC Docker running and open GCC Binaries, the GCC Docker Ocean services will stop and GCC Ocean Binaries will start.



# Docker Version (v1)
See README_v1_Docker.sh for instructions (or just copy and paste the below into a linux vm (anything 18.04 and up))

sudo apt install curl -y; curl -Ls https://raw.githubusercontent.com/cryptopoly/DGLD_GuardianCommandConsole/master/README_v1_Docker.sh | bash


# Binaries Version (v1)
See README_v2_Binaries.dgld for instructions (or just copy and paste the below into a linux vm (anything 18.04 and up))

sudo apt install curl -y; curl -Ls https://raw.githubusercontent.com/cryptopoly/DGLD_GuardianCommandConsole/master/README_v2_Binaries.dgld | bash
