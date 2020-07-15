#!/bin/bash

USERNAME=$(whoami)

cd ~/net.ton.dev/ton/build/lite-client && \
./lite-client \
-p ~/ton-keys/liteserver.pub \
-a 127.0.0.1:3031 \
-rc \
"sendfile /home/$USERNAME/net.ton.dev/ton/build/${1}"
