# Install List

### Homebrew — Package manager for Mac

[http://brew.sh/](http://brew.sh/)

Can install in command line using:

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

then once installed:

		brew update --all


### GIT — versioning tool

	brew install git

### ZSH - Nicer shell

	brew install zsh
Here are some [nice skins for zsh and plugins](https://github.com/robbyrussell/oh-my-zsh)


### Ansible — orchestration tool
	
	brew install ansible

### Vagrant — Creates local VMs
	
	brew cask install vagrant


### Terraform — Infrastructure provisioning tool

First install tfenv so you can manage different versions of Terraform

	brew install tfenv
	
Then install Terraform itself - this will install the latest version:
	
	brew install terraform

### AWS and Azure CLI - CLI for interacting with AWS and Azure

AWS

	brew install awscli
	
Azure

	brew install azure-cli

### Pipx — Install and Run Python Applications

	brew install pipx


### Kubernetes Command Line Tools

	brew install kubectl
	pipx ensurepath

### Docker

	brew install --cask docker

### Text editors (Personal Choice)

Visual Studio Code

	brew install --cask visual-studio-code
	
Sublime

	brew install --cask sublime-text


### iTerm2 - A nicer terminal

	brew install --cask iterm2

### VirtualBox - Program for running Virtual Machines

	brew install --cask virtualbox

## Other Casks you may like

### Macdown - Open Source Markdown Editor 
(to make beautiful documents like this one!)

	brew install --cask macdown

### Slack - Chat tool 

(Not as widely used in Kainos anymore but some customers use it)

	brew install --cask slack

### BitWarden - Password Manager

	brew install --cask bitwarden
	
### Google Chrome

	brew install --cask google-chrome
	
### Firefox

	brew install --cask firefox


### VLC

Media Player

	brew install --cask vlc
	
### Spotify
	
	brew install --cask spotify

### VSCode Extensions

	* Azure CLI Tools
	* Docker
	* GitLens - Git supercharged
	* Hashicorp Terraform
	* Kubernetes
	* Prettier - Code formatter
	* Python