#!/bin/bash
USERNAME=$(whoami)

cd ~/net.ton.dev/ton/build && \
crypto/fift \
-I/home/$USERNAME/net.ton.dev/ton/crypto/fift/lib \
-s /home/$USERNAME/net.ton.dev/ton/crypto/smartcont/wallet.fif \
${1} ${2} ${3} ${4} ${5}
