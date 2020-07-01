#!/bin/bash

CHECK_ENGINE=$(pgrep validator)


if [ -z "$CHECK_ENGINE" ]; then
        cd ~/net.ton.dev/scripts/ && ./run.sh
fi
