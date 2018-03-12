#!/bin/bash
if [ $# -ne 1 ]; then
    echo $0: usage: ./run.sh  password
    exit 0
fi

echo "$1" > ~/.vault_pass.txt
sed -i -e "s/PASSWRD/$1/g" ~/hosts


