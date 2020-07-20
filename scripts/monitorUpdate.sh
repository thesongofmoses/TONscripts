#!/bin/bash

#cat config to .py
cd ~/node.operator/configs  
cat node.config > ~/node.operator/monitor/alarm.py && cat cell.config > ~/node.operator/monitor/check.py

#update .py
cd ~/node.operator/monitor
rm alarm && rm check
wget https://raw.githubusercontent.com/kevintmax/monitor/master/alarm && wget https://raw.githubusercontent.com/kevintmax/monitor/master/check
cat ~/node.operator/monitor/alarm >> ~/node.operator/monitor/alarm.py && cat ~/node.operator/monitor/check >> ~/node.operator/monitor/check.py
rm alarm && rm check
