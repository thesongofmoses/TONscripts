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
pip uninstall -y python-telegram-bot; \
pip uninstall -y telegram; \
pip uninstall -y telegram-bot; \
pip install -y telegram-bot

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

#define cell for check.sh and node # for alarm.sh
cd ~/node.operator/monitor && \
echo "CELL=${CELL}" > checknode && ./check.sh
echo "NODE=${NODE}" > alarmnode && ./alarm.sh
