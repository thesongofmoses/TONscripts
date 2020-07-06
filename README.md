# node.operator

These scripts are created to help node operators. All the paths used are the default locations of https://github.com/tonlabs/net.ton.dev. 

1. Install dependencies, and download/setup repo:
	$ sudo apt install -y git && cd && rm -rf ~/node.operator && git clone https://github.com/thesongofmoses/node.operator.git && chmod +x -R 		~/node.operator/scripts && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && sudo apt install bc

2. Import crontab after completion of sync:
	$ crontab ~/node.operator/configs/crontab.config

3A. Updating without deleting logs and importing crontab
	$ cd && mkdir moses.update && cd moses.update && git clone test https://github.com/thesongofmoses/node.operator.git && rm -rf ~/node.operator/scripts && mv ~/moses.update/node.operator/scripts ~/node.operator/scripts && rm -rf ~/node.operator/configs && mv ~/moses.update/node.operator/configs ~/node.operator/configs && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && crontab ~/node.operator/configs/crontab.config && rm -rf ~/moses.update && cd && chmod +x -R ~/node.operator/scripts

3B. Updating without deleting logs and not importing crontab
	$ cd && mkdir moses.update && cd moses.update && git clone https://github.com/thesongofmoses/node.operator.git && rm -rf ~/node.operator/scripts && mv ~/moses.update/node.operator/scripts ~/node.operator/scripts && rm -rf ~/node.operator/configs && mv ~/moses.update/node.operator/configs ~/node.operator/configs && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && rm -rf ~/moses.update && cd && chmod +x -R ~/node.operator/scripts


#TEST BRANCH
A. Updating without deleting logs and importing crontab
	$ cd && mkdir moses.update && cd moses.update && git clone -b test https://github.com/thesongofmoses/node.operator.git && rm -rf ~/node.operator/scripts && mv ~/moses.update/node.operator/scripts ~/node.operator/scripts && rm -rf ~/node.operator/configs && mv ~/moses.update/node.operator/configs ~/node.operator/configs && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && crontab ~/node.operator/configs/crontab.config && rm -rf ~/moses.update && cd && chmod +x -R ~/node.operator/scripts

B. Updating without deleting logs and not importing crontab
	$ cd && mkdir moses.update && cd moses.update && git clone -b test https://github.com/thesongofmoses/node.operator.git && rm -rf ~/node.operator/scripts && mv ~/moses.update/node.operator/scripts ~/node.operator/scripts && rm -rf ~/node.operator/configs && mv ~/moses.update/node.operator/configs ~/node.operator/configs && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && rm -rf ~/moses.update && cd && chmod +x -R ~/node.operator/scripts
