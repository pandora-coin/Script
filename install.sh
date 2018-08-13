#!/bin/bash
sudo touch /var/swap.img
sudo chmod 600 /var/swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
mkswap /var/swap.img
sudo swapon /var/swap.img
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y nano htop git build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common libboost-all-dev
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get update -y
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
mkdir /root/temp
sudo git clone https://github.com/pandora /root/temp
chmod -R 755 /root/temp
cd /root/temp
./autogen.sh
./configure
make
make install
cd
mkdir /root/pandora
mkdir /root/.pandora
cp /root/temp/src/pandorad /root/pandora
cp /root/temp/src/pandora-cli /root/pandora
chmod -R 755 /root/pandora
chmod -R 755 /root/.pandora
sudo apt-get install -y pwgen
GEN_PASS=$(pwgen -1 -n 20)
echo -e "rpcuser=pandorauser\nrpcpassword=${GEN_PASS}\nrpcport=16511\nport=16510\nlisten=1\nmaxconnections=256\ndaemon=1\nserver=1\nrpcallowip=127.0.0.1\nexternalip=" >> /root/.pandora/pandora.conf
cd /root/pandora
./pandorad -daemon
sleep 10
