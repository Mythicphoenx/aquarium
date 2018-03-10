#!/bin/bash
if [ $# -ne 1 ]; then
    echo $0: usage: ./run.sh  password
    exit 0
fi

# Configure IP address in "hosts" file. If you have more than one
# Raspberry Pi, add more lines and enter details
#i=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
#ping 192.168.1.1 -c 20
#i=$(arp -na | grep -i b8:27:eb | cut -d" " -f2 | sed 's/(//' | sed 's/)//')

i=$(sudo arp-scan --interface=eth1 --localnet -r 15 | grep b8:27:eb | head -n1 | cut -d" " -f1)

echo "==$i=="
ping "$i" -c 20
#h=$(hostname)

exit 0

echo "$1" > ~/.vault_pass.txt

echo "[rpi]" > ~/aquarium/hosts
echo "$i ansible_connection=ssh ansible_ssh_user=pi ansible_ssh_pass="$1 >> ~/aquarium/hosts

ansible-playbook main.yml --vault-password-file ~/.vault_pass.txt

rm /home/pi/aquarium/hosts 2>/dev/null
rm /home/pi/aquarium/main.retry 2>/dev/null
rm /home/pi/aquarium/nohup.out 2>/dev/null

