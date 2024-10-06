#!/bin/bash

#cat << EOF
#    ,----..        .--.--.         ,---,.
#   /   /   \      /  /    `.    ,'  .'  \
#  /   .     :    |  :  /`. /  ,---.' .' |
# .   /   ;.  \   ;  |  |--`   |   |  |: |
#.   ;   /  ` ;   |  :  ;_     :   :  :  /
#;   |  ; \ ; |    \  \    `.  :   |    ;
#|   :  | ; | '     `----.   \ |   :     \
#.   |  ' ' ' :     __ \  \  | |   |   . |
#'   ;  \; /  |    /  /`--'  / '   :  '; |
# \   \  ',  . \  '--'.     /  |   |  | ;
#  ;   :     ; |    `--'---'   |   :   /
#   \   \ .'`--"               |   | ,'
#    `---`                     `----'
#EOF

##################################################################################
# Script Name:	QucikStartBot.sh
# Description:	This a simple script may enable to help you initial files, 
#		including source_list and .zshrc && .vimrc your LinuxOS like 
#		Kali,Ubuntu,CentOS and Debian, when you have to reinstall the 
#		OS for a couple times.
#		(source.list + packages update --> zsh + ohmyzsh + .zshrc -> git
#		-> vundle + .vimrc
# 
# Usage:	sudo ./startbot.sh [options]
#		-h | --help : Show usage information
#		-v | --version: Show script version
#
# Author:	moonup17
# Date: 	2023-09-28
# Version:	1.0
#
# Notes:	Modify this script as needed for your own purpose.
#		Ensure that it has execute permissions before running:
#		chmod +x startbot.sh and owing to packages update, you need running:
#  		sudo ./startbot.sh
#
# License: 	MIT License
###################################################################################

# Version information
VERSION="1.0"

# Function to display usage information
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help      Show this help message and exit"
    echo "  -v, --version   Show version information and exit"
}

# Function to display version information
version() {
    echo "$0 version $VERSION"
}

# Parse command-line arguments
while [[ "$1" != "" ]]; do
    case $1 in
        -h | --help )  shift
                       usage
                       exit 0
                       ;;
        -v | --version ) version
                         exit 0
                         ;;
        * )            echo "Invalid option: $1"
                       usage
                       exit 1
                       ;;
    esac
    shift
done

#source_list

ubuntu_sources="/etc/apt/sources.list"
debian_sources="/etc/apt/sources.list"
kali_sources="/etc/apt/sources.list"
centos_sources="etc/yum.repos.d/CentOS-Base.repo"

if [ -f /etc/os-release ]; then
	source /etc/os-release
	if [ $ID == "ubuntu" ]; then
		sources_file=$ubuntu_sources
	elif [ $ID == "debian" ]; then
		sources_file=$debian_sources
	elif [ $ID == "kali" ]; then
		sources_file=$kali_sources
	elif [ $ID == "centos" ]; then
		sources_file=$centos_sources
	else 
		echo " UNSUPPORTED SYSTEM :$ID !"
		exit 1
	fi
else	
	echo ' UNABLE TO DETECT SYSTEM TYPE '
	exit 1
fi

sudo cp $sources_file $sources_file.bak

if [ $ID == "ubuntu" ]; then
	echo 'Ubuntu20.04_focal source.list changing (x86-64)'
	sudo tee > /dev/null << EOL
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOL
	sudo apt update && \
	sudo apt upgrade && \
	sudo apt dist-upgrade && \
	echo ' Ubuntu source.list && packages update success '

elif [ $ID == "debian" ]; then
	echo 'Debian12_bookworm source.list changing (x86-64)' 
	sudo tee > dev/null << EOL 
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOL
	sudo apt update && \
	sudo apt upgrade && \
	sudo apt dist-upgrade &&\
	echo ' Debian source.list && packages update success '

elif [ $ID == "kali" ]; then
	
	echo 'Kali_Rooling source.list changing'
	sudo tee > /etc/apt/sources.list << EOL
deb https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main non-free contrib
EOL
	sudo apt update && \
	sudo apt upgrade && \
	sudo apt dist-upgrade && \
	sudo apt install dsniff && \
	sudo apt autoremove && \
	echo ' Kali source.list && packages update success ' 

elif [ $ID == "centos" ]; then
	echo 'CentOS_7 source.list changing'
	sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         	 -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos|g' \
	sudo yum clean alli && \
    	sudo yum makecache && \
	echo ' CentOS source.list && packages update success '
	
else 
	exit 1

fi

#zsh

shell_path=$SHELL
ohmyzsh() {	
	if [ -d "$HOME/.oh-my-zsh" ]; then
		cp $PWD/.zshrc /etc/zsh/.zshrc
	else 
		git clone https://github.com/ohmyzsh/ohmyzsh.git
		./ohmyzsh/tools/install.sh || echo ' file_path(ohmyzsh/tools/install.sh )wrong or install.sh does not exist '
		cp $PWD/.zshrc /etc/zsh/.zshrc
	echo ' .zshrc && oh-my-zsh done '
	fi 
}
if [ "$shell_path" == *"zsh"* ]; then 
	ohmyzsh
elif echo '/bin/zsh' | grep -qFf /etc/shells ; then
	ohmyzsh
else
	sudo apt install zsh
	ohmyzsh
fi
chsh -s /bin/zsh
echo 'zsh done'

#vim

if [ -d $HOME/.vim ]; then
	cp $PWD/.vimrc /etc/vim/.vimrc
else
	sudo apt install vim
	cp $PWD/.vimrc /etc/vim/.vimrc
fi

#git 

git config --global user.name "username"
git config --global user.email "user@email.com"
git config --list 
