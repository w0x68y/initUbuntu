#!/bin/bash

# Define colors...
RED=`tput bold && tput setaf 1`
GREEN=`tput bold && tput setaf 2`
YELLOW=`tput bold && tput setaf 3`
BLUE=`tput bold && tput setaf 4`
NC=`tput sgr0`

function RED(){
	echo -e "\n${RED}${1}${NC}"
}
function GREEN(){
	echo -e "\n${GREEN}${1}${NC}"
}
function YELLOW(){
	echo -e "\n${YELLOW}${1}${NC}"
}
function BLUE(){
	echo -e "\n${BLUE}${1}${NC}"
}

# Testing if root...
if [ $UID -ne 0 ]
then
	RED "You must run this script as root!" && echo
	exit
fi


BLUE "Install curl..."
sudo apt-get install -y curl

RED "Your IP address..."
curl cip.cc

BLUE "Updating repositories..."
sudo apt update

BLUE "Installing Sublime Text..." # according to https://www.sublimetext.com/docs/3/linux_repositories.html-
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install -y apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y sublime-text

BLUE "Installing terminator..."
sudo apt install -y terminator

BLUE "Setting terminator as the default terminal emulator..."
sed -i s/Exec=gnome-terminal/Exec=terminator/g /usr/share/applications/gnome-terminal.desktop

BLUE "Forcing a color prompt in ~/.bashrc..."
grep "export PS1" ~/.bashrc
if [ $? -eq 1 ]
then
	echo "export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> ~/.bashrc
fi

BLUE "Installing SimpleScreenRecorder..."
echo "" | sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder
sudo apt-get update
sudo apt-get install -y simplescreenrecorder

BLUE "Installing proxychains..."
sudo apt-get install -y proxychains

BLUE "Installing git..."
sudo apt install -y git

BLUE "Installing python2..."
sudo apt-get install -y python2

BLUE "Installing pip2..."
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py
sudo python2 get-pip.py

BLUE "Installing pip3..."
sudo apt-get install -y python3-pip

BLUE "Removing boilerplate home directories..."
rmdir ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Public ~/Templates ~/Videos

BLUE "Installing guake..."
sudo apt-get install -y guake

BLUE "Installing openvpn..."
sudo apt-get install -y openvpn

BLUE "Installing nmap..."
sudo apt-get install -y nmap

BLUE "Installing docker..."
sudo apt-get install -y docker.io
sudo groupadd docker
sudo usermod -aG docker `logname`

BLUE "Installing pinta..."
sudo apt-get install -y pinta

BLUE "Installing exiftool..."
sudo apt-get install -y exiftool

BLUE "Installing Python PIL..."
sudo apt-get install -y python-pil

BLUE "Installing sqlitebrowser..."
sudo apt-get install -y sqlitebrowser

BLUE "Installing Wireshark..."
sudo apt-get install -y wireshark

BLUE "Install Real VNC Viewer..."
wget "https://www.realvnc.com/download/file/viewer.files/VNC-Viewer-6.17.1113-Linux-x64.deb" -O vnc_viewer.deb
dpkg -i vnc_viewer.deb
rm vnc_viewer.deb

BLUE "Install Real VNC Connect (Server)..."
wget 'https://www.realvnc.com/download/file/vnc.files/VNC-Server-6.2.1-Linux-x64.deb' -O vnc_server.deb
dpkg -i vnc_server.deb
rm vnc_server.deb

BLUE "Adding VNC Connect (Server) service to the default startup /etc/rc.local..."
grep "vncserver-x11-serviced.service" /etc/rc.local
if [ $? -eq 1 ]
then
	echo "systemctl start vncserver-x11-serviced.service" >> ~/etc/rc.local
fi

BLUE "Installing python-requests..."
pip2 install requests
pip3 install requests

BLUE "Installing idle..."
sudo apt install -y idle

BLUE "Installing Python flask..."
sudo pip install flask

BLUE "Installing Python flask-login..."
sudo pip install flask-login

BLUE "Installing Python colorama..."
sudo pip install colorama

BLUE "Installing Python passlib..."
sudo pip install passlib

BLUE "Installing Binwalk..."
sudo apt install -y binwalk

BLUE "Installing hexedit..."
sudo apt install -y hexedit	

BLUE "Installing Python pwntools..."
sudo pip2 install pwntools

BLUE "Installing Go..."
sudo apt install -y golang-go
BLUE "Adding GOPATH and GOBIN to .bashrc, so future installs are easy.."
grep "export GOPATH" ~/.bashrc
if [ $? -eq 1 ]
then
	echo "export GOPATH=\$HOME/.go/" >> ~/.bashrc
fi
grep "export GOBIN" ~/.bashrc
if [ $? -eq 1 ]
then
	echo "export GOBIN=\$HOME/.go/bin" >> ~/.bashrc
	echo "export PATH=\$PATH:\$GOBIN" >> ~/.bashrc
fi

BLUE "Installing sqlite..."
sudo apt install -y sqlite	

BLUE "Installing nikto..."
sudo apt install -y nikto

BLUE "Installing pdfcrack..."
sudo apt install -y pdfcrack

BLUE "Installing Oracle Java 8..."
echo "" | sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-installer

BLUE "Installing fcrackzip..."
sudo apt install -y fcrackzip

BLUE "Installing unrar..."
sudo apt install -y unrar

BLUE "Installing steghide..."
sudo apt install -y steghide

BLUE "Installing cmake..."
sudo apt install -y cmake

BLUE "Installing mplayer..."
sudo apt install -y mplayer

BLUE "Installing tcpflow..."
sudo apt install -y tcpflow

BLUE "Installing Python scapy..."
sudo pip install scapy

BLUE "Installing the thing that 7z2john.pl needs..."
sudo apt install libcompress-raw-lzma-perl 

BLUE "Installing dos2unix..."
sudo apt install libcompress-raw-lzma-perl

BLUE "Installing sqlmap..."
sudo snap install sqlmap

BLUE "Installing postgresql..."
sudo apt-get install -y postgresql

BLUE "Installing msf..."
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall

RED "create a tools folder in ~/"
mkdir ~/tools
cd ~/tools/

BLUE "Downloading stegsolve.jar..."
wget "http://www.caesum.com/handbook/Stegsolve.jar" -O "stegsolve.jar"
chmod +x "stegsolve.jar"

BLUE "Installing Aquatone"
go get github.com/michenriksen/aquatone

BLUE "Installing Chromium"
sudo snap install chromium

BLUE "installing JSParser"
git clone https://github.com/nahamsec/JSParser.git
cd JSParser*
sudo python setup.py install
cd ~/tools/

BLUE "installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip install -r requirements.txt
cd ~/tools/

BLUE "installing wpscan"
git clone https://github.com/wpscanteam/wpscan.git
cd wpscan*
sudo gem install bundler && bundle install --without test
cd ~/tools/

BLUE "installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools/

BLUE "installing lazys3"
git clone https://github.com/nahamsec/lazys3.git
cd ~/tools/

BLUE "installing knock.py"
git clone https://github.com/guelfoweb/knock.git
cd ~/tools/

BLUE "installing lazyrecon"
git clone https://github.com/nahamsec/lazyrecon.git
cd ~/tools/

BLUE "installing httprobe"
go get -u github.com/tomnomnom/httprobe 

BLUE "installing unfurl"
go get -u github.com/tomnomnom/unfurl 

BLUE "installing waybackurls"
go get github.com/tomnomnom/waybackurls

BLUE "Installing gobuster..."
go install github.com/OJ/gobuster/v3@latest

BLUE "Installing impacket..."
cd ~/tools/
git clone https://github.com/SecureAuthCorp/impacket.git
pip3 install .
cd ~/tools/

BLUE "Installing ksubdomain..."
sudo apt-get install -y libpcap-dev
git clone https://github.com/knownsec/ksubdomain
cd ksubdomain
go mod download
cd cmd
go build ksubdomain.go
sudo cp ksubdomain /usr/local/bin/
cd ~/tools/

BLUE "Installing subfinder..."
git clone https://github.com/projectdiscovery/subfinder.git
cd /subfinder/v2/cmd/subfinder/
go build
sudo cp subfinder /usr/local/bin/
cd ~/tools/

BLUE "Installing httpx..."
git clone https://github.com/projectdiscovery/httpx.git
cd httpx/cmd/httpx
go build
sudo mv httpx /usr/local/bin/
httpx -version
cd ~/tools/

BLUE "Installing Neo-reGeorg..."
cd ~/tools/
git clone https://github.com/L-codes/Neo-reGeorg.git
cd ~/tools/

BLUE "Installing assetfinder..."
cd ~/tools/
git clone https://github.com/tomnomnom/assetfinder.git
cd assetfinder/
go build
sudo cp assetfinder /usr/local/bin/
assetfinder -h
cd ~/tools/

BLUE "Installing JSFinder..."
cd ~/tools/
git clone https://github.com/Threezh1/JSFinder.git
cd JSFinder*
python3 JSFinder.py -h
cd ~/tools/

BLUE "downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/

BLUE "Installing oneforall..."
cd ~/tools/
git clone https://github.com/shmilylty/OneForAll.git
cd OneForAll/
python3 -m pip install -U pip setuptools wheel -i https://mirrors.aliyun.com/pypi/simple/
pip3 install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
python3 oneforall.py --help
cd ~/tools/

BLUE "Installing PocList..."
cd ~/tools/
git clone https://github.com/Yang0615777/PocList.git
cd ~/tools/

BLUE "Installing zsh..."
sudo apt-get install -y zsh

# BLUE "Installing ohmyzsh..."
# cd ~/tools/
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone git://github.com/zsh-users/zsh-autosuggestions \$ZSH_CUSTOM/plugins/zsh-autosuggestions
# subl ~/.zshrc
