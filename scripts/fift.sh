#!/bin/bash

USERNAME=$(whoami)

cd ~/net.ton.dev/ton/build && crypto/fift -I/home/$USERNAME/net.ton.dev/ton/crypto/fift/lib -s /home/$USERNAME/net.ton.dev/ton/crypto/smartcont/${1} 
