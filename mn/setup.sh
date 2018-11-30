#/bin/bash

cd ~
echo "****************************************************************************"
echo "* Ubuntu 16.04 is the recommended opearting system for this install.       *"
echo "*                                                                          *"
echo "* This script will install and configure your APR Coin masternodes.        *"
echo "****************************************************************************"
echo && echo && echo
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo && echo && echo

echo "Do you want to install all needed dependencies (no if you did it before)? [y/n]"
read DOSETUP

if [[ $DOSETUP =~ "y" ]] ; then
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y nano htop git
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
  sudo apt-get install -y libboost-all-dev
  sudo apt-get install -y libevent-dev
  sudo apt-get install -y libminiupnpc-dev
  sudo apt-get install -y autoconf
  sudo apt-get install -y automake unzip
  sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
  sudo apt-get update
  sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
  sudo apt-get update && sudo apt-get install libzmq-5* -y

  cd /var
  sudo touch swap.img
  sudo chmod 600 swap.img
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
  sudo mkswap /var/swap.img
  sudo swapon /var/swap.img
  sudo free
  sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
  cd

  sudo apt-get install -y ufw
  sudo ufw allow ssh/tcp
  sudo ufw limit ssh/tcp
  sudo ufw logging on
  echo "y" | sudo ufw enable
  sudo ufw status

  mkdir -p ~/bin
  echo 'export PATH=~/bin:$PATH' > ~/.bash_aliases
  source ~/.bashrc
fi

## COMPILE AND INSTALL
wget https://github.com/XeZZoR/scripts/raw/master/APR/aprcoin-cli
wget https://github.com/XeZZoR/scripts/raw/master/APR/aprcoin-qt
wget https://github.com/XeZZoR/scripts/raw/master/APR/aprcoin-tx
wget https://github.com/XeZZoR/scripts/raw/master/APR/aprcoind
sudo chmod 755 aprcoin*
sudo mv aprcoin* /usr/bin

CONF_DIR=~/.aprcoin/
mkdir $CONF_DIR
CONF_FILE=aprcoin.conf
PORT=3133

wget https://github.com/XeZZoR/scripts/raw/master/APR/peers.dat -O $CONF_DIR/peers.dat

IP=$(curl -s4 icanhazip.com)

echo ""
echo "Enter masternode private key for node $ALIAS"
read PRIVKEY

echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
echo "listen=1" >> $CONF_DIR/$CONF_FILE
echo "server=1" >> $CONF_DIR/$CONF_FILE
echo "daemon=1" >> $CONF_DIR/$CONF_FILE
echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
echo "masternode=1" >> $CONF_DIR/$CONF_FILE
echo "" >> $CONF_DIR/$CONF_FILE
echo "" >> $CONF_DIR/$CONF_FILE
echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
echo "masternodeaddr=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE

echo "addnode=[2001:0:4137:9e76:144f:1354:bb79:a4a3]:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:6abd:286e:1da0:230f:9a1]:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=209.250.240.35:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=64.154.38.181:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=18.219.234.121:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=63.209.35.108:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=45.76.5.59:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=206.189.160.179:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:953c:280f:21e5:3944:e3ed]:51090" >> $CONF_DIR/$CONF_FILE
echo "addnode=52.15.56.27:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=68.168.84.90:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:953c:2818:35e9:ed24:395a]:49792"  >> $CONF_DIR/$CONF_FILE
echo "addnode=140.82.54.120:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:90d7:c6b:25ed:c93e:f2b9]:55251"  >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:953c:1097:b40:cbf0:653d]:50345" >> $CONF_DIR/$CONF_FILE
echo "addnode=209.246.143.117:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=199.247.21.63:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:4137:9e76:c5:14fb:dc4e:f39e]:58011" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:953c:286e:3c12:dc5f:5901]:62148" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:4137:9e76:187c:2ec0:bd54:a150]:60272" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:6ab8:3038:1517:b8c6:f4b7]:49644" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:90d7:347c:15b8:f280:11d5]:54765" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:19f0:5:903:5400:1ff:fe78:434f]:45684" >> $CONF_DIR/$CONF_FILE
echo "addnode=136.144.177.141:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:953c:3c5d:2ae9:ed23:518d]:50841" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:4137:9e76:3ce5:fbff:b2c5:df56]:59152" >> $CONF_DIR/$CONF_FILE
echo "addnode=185.223.28.179:3133" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:5ef5:79fb:30c7:e6f:e73b:d6bc]:64296" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:9d38:953c:2877:26a0:ed13:4371]:50111" >> $CONF_DIR/$CONF_FILE
echo "addnode=[2001:0:4137:9e76:8e1:15b4:a310:7243]:3133" >> $CONF_DIR/$CONF_FILE

sudo ufw allow $PORT/tcp

aprcoind -daemon
