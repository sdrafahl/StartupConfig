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

# Installing Haskell
sudo apt install ghc

# Installing Java
sudo apt install openjdk-8-jre-headless

# Installing Metals
curl -L -o coursier https://git.io/coursier
chmod +x coursier
sudo ./coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=emacs \
  org.scalameta:metals_2.12:0.7.0 \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-emacs -f

# Installing SBT
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt

sudo unzip terraform_0.12.10_linux_amd64.zip
sudo /usr/local/bin/terraformmv terraform 
export PATH=$PATH:/usr/local/bin/terraform
