#!/bin/bash

#change hostname from obvious Kali
echo "user1" > /etc/hostname
sed -i -e 's/kali/user1/' /etc/hosts


# set bash mode to vi
echo "set editing-mode vi" >> /etc/inputrc

apt-get update && upgrade
#apt install virtualbox

#uninstall and install packages update searchsploit
apt-get -y remove proxychains
apt-get -y install openvas tor hexchat hostapd-wpe kde-spectacle synaptic libpq-dev \
bridge-utils libnl-3-dev libgcrypt11-dev libnl-genl-3-dev devscripts cupp \
mingw-w64 eyewitness libxslt-dev libxml2-dev

searchsploit -u

#start Firefox 1st time to create profile to edit later
firefox
sleep 4
killall firefox

#download and install new proxychains
cd '/root/Downloads'
git clone https://github.com/rofl0r/proxychains-ng.git
cd '/root/Downloads/proxychains-ng'
./configure --sysconfdir=/etc
make
make install
make install-config

cd '/etc'
rm proxychains.conf
curl -o proxychains.conf https://raw.githubusercontent.com/brohan/proxychains4conf/master/proxychains.conf

cd '/root'
echo "alias proxychains='proxychains4'" >> .bash_aliases

#edit firefox about:config by creating a user.js file in profile directory
profile_dir=$(find /root/.mozilla/firefox -name '*.default')
cd $profile_dir
cat << EOF >> user.js
user_pref("media.peerconnection.enabled", false);
user_pref("geo.enabled", false);
EOF

#start audio at boot
#cd '/root'
#cat <<EOF >> .bashrc

#Pulseaudio with terminal startup
#until [[ `ps aux | grep "pulseaudio -D" | grep -v grep | wc -l` -eq 1 ]]
#do
#    pulseaudio -D >/dev/null 2>&1
#    if [[ `ps aux | grep "pulseaudio -D" | grep -v grep | wc -l` -gt 1 ]]
#    then
#        kill -9 `pidof pulseaudio`
#        pulseaudio -D
#    fi
#done
#EOF

#add nameservers
cd '/etc'
rm resolv.conf
cat <<EOF >> resolv.conf
nameserver 37.58.80.195
nameserver 185.83.217.248
EOF
chatter +i resolv.conf

#download and install atom text editor
cd '/root/Downloads'
wget https://atom.io/download/deb -O atom.deb
dpkg -i atom.deb

#git CMSmap
cd '/root/Downloads'
git clone https://github.com/Dionach/CMSmap.git

#git NoSQLMap
cd '/root/Downloads'
git clone https://github.com/tcstool/NoSQLMap.git
cd '/root/Downloads/NoSQLMap'
python setup.py install

#git SMBexec
cd '/root/Downloads'
https://github.com/pentestgeek/smbexec.git
cd 'root/Downloads/smbexec'
bundle install
./install.sh

#git Veil
cd '/root/Downloads'
git clone https://github.com/Veil-Framework/Veil-Evasion.git

#git printer exploits
cd '/root/Download"
git clone https://github.com/MooseDojo/praedasploit /opt/praedasploit

#get DSHashes
cd '/root/Downloads'
wget https://raw.githubusercontent.com/lanmaster53/ptscripts/master/dshashes.py

#git Net-Creds
cd '/root/Downloads'
git clone https://github.com/DanMcInerney/net-creds.git

#git Fuzzing Lists
cd '/root/Downloads'
git clone https://github.com/danielmiessler/SecLists.git

#git The Backdoor Factory
cd '/root/Downloads'
git clone https://github.com/secretsquirrel/the-backdoor-factory
cd '/root/Downloads/the-backdoor-factory
./install.sh

#git custom Playbook scripts
cd '/root/Downloads'
git clone https://github.com/cheetz/Easy-P.git
git clone https://github.com/cheetz/Password_Plus_One
git clone https://github.com/cheetz/PowerShell_Popup
git clone https://github.com/cheetz/icmpshock
git clone https://github.com/cheetz/brutescrape
git clone https://github.com/cheetz/reddit_xss

#git Wordhound
cd '/root/Downloads'
git clone https://bitbucket.org/mattinfosec/wordhound.git
cd '/root/Downloads/wordhound'
./install.sh

#git httpscreenshot
cd '/root/Downloads'
pip install selenium
git clone https://github.com/breenmachine/httpscreenshot.git
cd '/root/Downloads/httpscreenshot'
chmod +x install-dependencies.sh && ./install-dependencies.sh


#download jython for Burpsuite extension
cd '/root/Downloads'
wget http://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.7.0/jython-installer-2.7.0.jar -O jython-installer-2.7.0.jar

#download and install fluxion - for evil twin WPA capture
git clone https://github.com/deltaxflux/fluxion
cd '/root/Downloads/fluxion'
./Installer.sh
cd '/root'

#enable packet forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

#disable NetworkManager for wlan1mon

cd '/etc/NetworkManager'
cat << EOF >> NetworkManager.conf
[keyfile]
unmanaged-devices=interface-name:wlan0mon;interface-name:wlan1mon;interface-name:wlan2mon;interface-name:wlan3mon;interface-name:wlan4mon;interface-name:wlan5mon;interface-name:wlan6mon;interface-name:wlan7mon;interface-name:wlan8mon;interface-name:wlan9mon;interface-name:wlan10mon;interface-name:wlan11mon;interface-name:wlan12mon
EOF


# add proper locale so that sparta works
echo 'export LC_ALL=en_US.UTF-8'>>.bashrc
source .bashrc 

#restart services to enable changes
pulseaudio

#clone run, and install Lee Baird discover script
cd
git clone https://github.com/leebaird/discover /opt/discover/
cd /opt/discover
./update
chmod 777 /usr/share/theharvester/theHarvester.py
cd
mkdir bin
echo "export PATH=$PATH:/root/bin"  >> .bashrc
ln -s /opt/discover/discover.sh /root/bin/discover

echo "Install neo4j at"
firefox -new-tab https://neo4j.com/download/community-edition
