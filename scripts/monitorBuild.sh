#!/bin/bash

NODE="${1}"
API_KEY=$(echo "$NODE" | cut -c 1)
CELL_UNPARSED=$(expr "$NODE" + 2)
CELL=$(printf "B%s" "$CELL_UNPARSED")

#install .pys
rm -rf ~/node.operator/monitor && \
cd ~/node.operator && \
git clone https://github.com/kevintmax/monitor/ && \
chmod -R +x ~/node.operator/monitor

#install tg bot
pip uninstall python-telegram-bot; \
pip uninstall telegram; \
pip uninstall telegram-bot; \
pip install telegram-bot

#install python, gspread,psutil
sudo apt install -y python && \
sudo apt update && \
sudo apt install -y python-pip && \
sudo pip install gspread && \
sudo pip install --upgrade oauth2client && \
sudo pip install psutil

#install api key
cd ~/node.operator/configs && \
wget https://raw.githubusercontent.com/kevintmax/pykey/master/"${API_KEY}".json
mv "${API_KEY}".json py.json

#define cell for check.py and node # for alarm.py
cd ~/node.operator/configs && \
echo "CELL=${CELL}" > cell.config && ~/node.operator/monitor/check.sh
echo "NODE=${NODE}" > node.config && ~/node.operator/monitor/alarm.sh
