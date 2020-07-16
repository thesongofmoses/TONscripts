#!/bin/bash

USERNAME=$(whoami)

GENPHRASE=$(cd ~/net.ton.dev/ton/build/ && \
        crypto/fift \
        -I/home/$USERNAME/net.ton.dev/ton/crypto/fift/lib \
        -s /home/$USERNAME/net.ton.dev/ton/crypto/smartcont/new-wallet.fif "${1}" "${2}")

echo $GENPHRASE | tee ~/net.ton.dev/ton/build/"${2}".dump
