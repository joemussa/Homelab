#!/bin/bash

echo "Change network settings..."
read -p "Hostname: " HOSTNAME
read -p "IP address in CIDR notation: " IP_ADDRESS
read -p "Gateway IP: " GATEWAY_ADDRESS
read -p "DNS IP: " DNS_ADDRESS

sudo hostnamectl set-hostname "$HOSTNAME"

sudo touch ~/99-netplan.yaml

echo "network:" > ~/99-custom.yaml
echo "  ethernets:" >> ~/99-custom.yaml
echo "    eth0:" >> ~/99-custom.yaml
echo "      dhcp4: false" >> ~/99-custom.yaml
echo "      addresses:" >> ~/99-custom.yaml
echo "       - $IP_ADDRESS" >> ~/99-custom.yaml
echo "      routes:" >> ~/99-custom.yaml
echo "       - to: default" >> ~/99-custom.yaml
echo "         via: $GATEWAY_ADDRESS" >> ~/99-custom.yaml
echo "      nameservers:" >> ~/99-custom.yaml
echo "        addresses: [$DNS_ADDRESS]" >> ~/99-custom.yaml
echo "  version: 2" >> ~/99-custom.yaml

sudo cp ~/99-netplan.yaml /etc/netplan/99-netplan.yaml

sudo netplan apply

echo "Restart to complete host deployment..."
