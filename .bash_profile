# Installing Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# Installing Emacs
sudo add-apt-repository ppa:kelleyk/emacs -y
sudo apt-get update -y
sudo apt install emacs26 -y

# Installing Emacs init script
git clone https://github.com/sdrafahl/StartupConfig.git
rm -fr .emacs.d
sudo mv StartupConfig/.emacs.d/ ./
rm -fr StartupConfig
