#!/bin/bash

#uninstall and install packages update searchsploit
apt-get -y remove proxychains
apt-get -y install tor hexchat hostapd-wpe

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
echo "alias proxychains='proxychains4'" >> .bashrc

#edit firefox about:config by creating a user.js file in profile directory
profile_dir=$(find /root/.mozilla/firefox -name '*.default')
cd $profile_dir
cat << EOF >> user.js
user_pref("media.peerconnection.enabled", false);
user_pref("geo.enabled", false);
EOF

#start audio at boot
cd '/root'
cat <<EOF >> .bashrc

#Pulseaudio with terminal startup
until [[ `ps aux | grep "pulseaudio -D" | grep -v grep | wc -l` -eq 1 ]]
do
    pulseaudio -D >/dev/null 2>&1
    if [[ `ps aux | grep "pulseaudio -D" | grep -v grep | wc -l` -gt 1 ]]
    then
        kill -9 `pidof pulseaudio`
        pulseaudio -D
    fi
done
EOF

#add nameservers
cd '/etc'
rm resolv.conf
cat <<EOF >> resolv.conf
nameserver 37.58.80.195
nameserver 185.83.217.248
EOF

#download explot-db binaries
cd '/root/Downloads'
git clone https://github.com/offensive-security/exploit-database-bin-sploits.git

#restart services to enable changes
pulseaudio

