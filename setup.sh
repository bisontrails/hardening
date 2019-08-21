#!/usr/bin/env bash

echo "1. Update, upgrade, dist-upgrade"
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

echo "2. Install and configure dropbear-initramfs"
apt-get install dropbear-initramfs

echo "DROPBEAR_OPTIONS=\"-p 4748\" -s -j -k -I 60" >> /etc/dropbear-initramfs/config

echo "Enter the public key for the dropbear authorized_keys"
read dropbear_authorized_key

echo "$dropbear_authorized_key" >> /etc/dropbear-initramfs/authorized_keys

update-initramfs -u

echo "3. Setup ssh key for bison account"
echo "Enter the public key for the .ssh folder for bison user"
read bison_user_authorized_key

mkdir /home/bison/.ssh
echo "$bison_user_authorized_key" >> /home/bison/.ssh/authorized_keys


echo "4. Adding bisonyubi user and configuring .ssh folder"

adduser bisonyubi
usermod -aG sudo bisonyubi
usermod -aG bison bisonyubi

echo "Enter the public key for the .ssh folder for bisonyubi user"
read bisonyubi_user_authorized_key


echo "5. Add tmkms user, no ssh access!"
adduser tmkms
