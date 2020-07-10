#!/bin/bash

pkill -f validator-engine
cd ~/net.ton.dev
git checkout master
git fetch --all --prune
git reset --hard origin/master
cd ~/net.ton.dev/scripts && ./build.sh
cd ~/net.ton.dev/scripts && ./run.sh
cd ~/net.ton.dev/ton
git rev-parse HEAD
