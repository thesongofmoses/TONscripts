# node.operator

These scripts are created to help node operators. All the paths used are the default locations of https://github.com/tonlabs/net.ton.dev. 


For first time install:

cd && rm -rf ~/node.operator && git clone https://github.com/thesongofmoses/node.operator.git && chmod +x -R ~/node.operator/scripts && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && crontab ~/node.operator/configs/crontab.config && rm ~/node.operator/logs/dummy.log && sudo apt install bc

For update, execute:

cd && mkdir moses.update && cd moses.update && git clone https://github.com/thesongofmoses/node.operator.git && rm -rf ~/node.operator/scripts && rm -rf ~/node.operator/configs && mv ~/moses.update/node.operator/scripts ~/node.operator/scripts && mv ~/moses.update/node.operator/configs ~/node.operator/configs && cat ~/moses.update/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && crontab ~/moses.update/node.operator/configs/crontab.config && rm -rf ~/moses.update && cd && chmod +x -R ~/node.operator/scripts
