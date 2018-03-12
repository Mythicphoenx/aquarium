#!/bin/bash
if [ $# -ne 1 ]; then
    echo $0: usage: ./run.sh  password
    exit 0
fi

rpi_ip=$(grep ssh ~/hosts | cut -d' ' -f1)

sshpass -p raspberry ssh $rpi_ip 'echo -e "raspberry\n'$1'\n'$1'" | passwd pi'

echo "$1" > ~/.vault_pass.txt
sed -i -e "s/PASSWRD/$1/g" ~/hosts


