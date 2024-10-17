# programming-env


### initial setup
# Key Pair
We'll need a public key that we can use during the creation of the instances. 
ssh-keygen -t rsa

# Persistant Volume
We need to setup up the persistent volume that we will attach to the instances. This will be useful for storing 
configuration and testing data.

- sudo apt update
- sudo apt-get install xfsprogs
- sudo mkfs -t xfs /dev/nvme1n1
- sudo mkdir /data
- sudo mount /dev/nvme1n1 /data

some other useful command
lsblk
sudo file -s /device/name

# What is installed on volume 
// C compiler
- sudo apt install build-essential
// mpi package
- sudo apt install openmpi-bin
// debugging
- sudo apt install valgrind
- sudo apt install gdb
// for development
- sudo apt install git
