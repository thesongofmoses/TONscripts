killall -15 validator-engine
echo 0 > /var/ton-work/node.log
cd ~/net.ton.dev/scripts && ./run.sh
