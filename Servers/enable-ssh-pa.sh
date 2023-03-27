#!/bin/bash
echo "Enabling ssh password authentication..."
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd
