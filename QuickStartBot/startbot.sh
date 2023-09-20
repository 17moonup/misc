#!/bin/bash

# source.list + packages update -> zsh + ohmyzsh + .zshrc -> git -> ...

echo ' < A QUICK START BOT FOR Ubuntu Debian Kali CentOS > '
###############################################################################
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
	sudo tee > dev/null << EOL
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

fi
###############################################################################
shell_path=$SHELL

ohmyzsh() {
	git clone https://github.com/ohmyzsh/ohmyzsh.git
	./ohmyzsh/tools/install.sh || echo ' file_path(ohmyzsh/tools/install.sh )wrong or install.sh does not exist '
	echo ' zsh && ohmyzsh done '
}

if [ "$shell_path" == *"zsh"* ]; then 
	ohmyzsh
else
	if [ grep -q '/bin/zsh' /etc/shells ]; then
		ohmyzsh
	else
		sudo apt install zsh
		ohmyzsh
	fi
fi
###############################################################################
sudo apt install git 
git config --global user.name "17moonup"
git config --global user.email "17moonup@gmail.com"
git config --list 


