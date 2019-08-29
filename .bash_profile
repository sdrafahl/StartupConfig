# Installing Emacs
sudo add-apt-repository ppa:kelleyk/emacs -y
sudo apt-get update -y
sudo apt install emacs26 -y

# Installing Emacs init script
git clone https://github.com/sdrafahl/StartupConfig.git
rm -fr .emacs.d
sudo mv StartupConfig/.emacs.d/ ./
rm -fr StartupConfig
