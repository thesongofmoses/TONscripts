# node.operator

These scripts are created to help node operators. All the paths used are the default locations of https://github.com/tonlabs/net.ton.dev.

1. INITIAL INSTALL

Install dependencies and download/setup repo
	
	sudo apt install -y git && cd && rm -rf ~/node.operator && git clone https://github.com/thesongofmoses/node.operator.git && chmod +x -R ~/node.operator/scripts && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && sudo apt install bc

Import crontab after completion of sync

	crontab ~/node.operator/configs/crontab.config

2. UPDATE

Update and import crontab
	
	cd && rm -rf moses.update && mkdir moses.update && cd moses.update && git clone https://github.com/thesongofmoses/node.operator.git && rm -rf ~/node.operator/scripts && mv ~/moses.update/node.operator/scripts ~/node.operator/scripts && mv ~/moses.update/node.operator/configs/bashrc.config ~/node.operator/configs/bashrc.config && mv ~/moses.update/node.operator/configs/crontab.config ~/node.operator/configs/crontab.config && mv ~/moses.update/node.operator/configs/scripts.config ~/node.operator/configs/scripts.config && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && crontab ~/node.operator/configs/crontab.config && rm -rf ~/moses.update && cd && chmod +x -R ~/node.operator/scripts

Update but NOT import crontab
	
	cd && rm -rf moses.update && mkdir moses.update && cd moses.update && git clone https://github.com/thesongofmoses/node.operator.git && rm -rf ~/node.operator/scripts && mv ~/moses.update/node.operator/scripts ~/node.operator/scripts && mv ~/moses.update/node.operator/configs/bashrc.config ~/node.operator/configs/bashrc.config && mv ~/moses.update/node.operator/configs/crontab.config ~/node.operator/configs/crontab.config && mv ~/moses.update/node.operator/configs/scripts.config ~/node.operator/configs/scripts.config && cat ~/node.operator/configs/bashrc.config > ~/.bashrc && source ~/.bashrc && rm -rf ~/moses.update && cd && chmod +x -R ~/node.operator/scripts
