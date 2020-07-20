#!/bin/bash

NODE=$(cat /etc/hostname)
API_KEY=$(echo "$NODE" | cut -c 1)
CELL_UNPARSED=$(expr "$NODE" + 2)
CELL=$(printf "B%s" "$CELL_UNPARSED")

#install .pys
rm -rf ~/node.operator/monitor && \
cd ~/node.operator && \
git clone https://github.com/kevintmax/monitor/ && \
chmod -R +x ~/node.operator/monitor

#install tg bot
pip uninstall python-telegram-bot telegram telegram-bot
pip install telegram-bot

#install python, gspread,psutil
sudo apt update
sudo apt install -y python python-pip && \
sudo pip install gspread --upgrade oauth2client psutil

#install api key
cd ~/node.operator/configs && \
wget https://raw.githubusercontent.com/kevintmax/pykey/master/"${API_KEY}".json
mv "${API_KEY}".json py.json

#define cell for check.py and node # for alarm.py
cd ~/node.operator/configs && \
echo "CELL='${CELL}'" > cell.config
echo "NODE='${NODE}'" > node.config

#cat config to .py
cat node.config > ~/node.operator/monitor/alarm.py && cat cell.config > ~/node.operator/monitor/check.py

#execute alarm/check.sh
cd ~/node.operator/monitor
rm alarm && rm check
wget https://raw.githubusercontent.com/kevintmax/monitor/master/alarm && wget https://raw.githubusercontent.com/kevintmax/monitor/master/check
cat ~/node.operator/monitor/alarm >> ~/node.operator/monitor/alarm.py && cat ~/node.operator/monitor/check >> ~/node.operator/monitor/check.py
rm alarm && rm check
