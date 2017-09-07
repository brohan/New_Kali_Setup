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
mingw-w64 eyewitness libxslt-dev libxml2-dev vega cherrytree python3-pip dtrx neo4j \
kdbg pure-ftpd crackmapexec python-pyftpdlib pure-ftpd vsftpd seclists gobuster cifs-utils \
bloodhound

searchsploit -u

#start Firefox 1st time to create profile to edit later
firefox
sleep 4
ps killall firefox-esr

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

source ~/.bashrc

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

#git updated reconscan by RoliSoft
cd '/root/Downloads'
git clone https://github.com/RoliSoft/ReconScan.git
cd '/root/Downloads/ReconScan'
chmod +x recon.py
chmod +x vulnscan.py
./vulnscan.py -u
pip3 install python-libnmap
pip3 install colorama
pip3 install lxml

#download and install atom text editor
cd '/root/Downloads'
wget https://atom.io/download/deb -O atom.deb
dpkg -i atom.deb

#git CMSmap
cd '/root/Downloads'
git clone https://github.com/Dionach/CMSmap.git

#git knock for port knocking
cd '/root/Downloads'
git clone https://github.com/grongor/knock.git

#git NoSQLMap
cd '/root/Downloads'
git clone https://github.com/tcstool/NoSQLMap.git
cd '/root/Downloads/NoSQLMap'
python setup.py install

#git SMBexec
cd '/root/Downloads'
git clone https://github.com/pentestgeek/smbexec.git
cd 'root/Downloads/smbexec'
bundle install
./install.sh

#git ps1encode to encode msf payloads for powershell
cd '/root/Downloads'
git clone https://github.com/CroweCybersecurity/ps1encode

#git updated pth-toolkit
cd '/root/Downloads'
git clone https://github.com/byt3bl33d3r/pth-toolkit.git

#git unix-privesc-check
cd '/root/Downloads'
git clone https://github.com/pentestmonkey/unix-privesc-check.git

#git LinEnum
cd '/root/Downloads'
git clone https://github.com/rebootuser/LinEnum.git

#wget linuxprivchecker
cd '/root/Downloads'
mkdir linuxprivchecker
cd '/root/Downloads/linuxprivchecker'
wget https://www.securitysift.com/download/linuxprivchecker.py

#git install Veil-Framework
cd '/root/Downloads'
git clone https://github.com/Veil-Framework/Veil.git
cd '/root/Downloads/Veil/setup'
./setup.sh -c

#git printer exploits
cd '/root/Download"
git clone https://github.com/MooseDojo/praedasploit /opt/praedasploit

#get short private rsa keys for 2006 Debian openssl short key exploit
mkdir /usr/share/wordlists/short_ssh_priv_keys
cd /usr/share/wordlists/short_ssh_priv_keys
wget http://digitaloffense.net/tools/debian-openssl/debian_ssh_dsa_1024_x86.tar.bz2
wget http://digitaloffense.net/tools/debian-openssl/debian_ssh_rsa_2048_x86.tar.bz2
tar -xvjf debian_ssh_rsa_2048_x86.tar.bz2
tar -xvjf debian_ssh_dsa_1024_x86.tar.bz2

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

#download accesschk versions
curl --progress -k -L -f "https://web.archive.org/web/20080530012252/http://live.sysinternals.com/accesschk.exe" > /usr/share/windows-binaries/accesschk_v5.02.exe \
curl --progress -k -L -f "https://download.sysinternals.com/files/AccessChk.zip" > /usr/share/windows-binaries/AccessChk.zip \
unzip -q -o -d /usr/share/windows-binaries/ /usr/share/windows-binaries/AccessChk.zip
rm -f /usr/share/windows-binaries/{AccessChk.zip,Eula.txt}

#download jython for Burpsuite extension
cd '/root/Downloads'
wget http://search.maven.org/remotecontent?filepath=org/python/jython-installer/2.7.0/jython-installer-2.7.0.jar -O jython-installer-2.7.0.jar

#download and install fluxion - for evil twin WPA capture
git clone https://github.com/wi-fi-analyzer/fluxion
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

# change gdb disassembly-flavor to intel
cd /root
echo "set disassembly-flavor intel" > .gdbinit

# add proper locale so that sparta works
echo 'export LC_ALL=en_US.UTF-8'>>.bashrc
source .bashrc

#restart services to enable changes
pulseaudio

#disable apache php

a2dismod php7.0

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
