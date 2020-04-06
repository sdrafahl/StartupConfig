# updating
sudo apt-get update
sudo apt-get upgrade

# Installing Spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# Installing AWSCLI
sudo apt install awscli

# Installing Emacs
sudo add-apt-repository ppa:kelleyk/emacs -y
sudo apt-get update -y
sudo apt install emacs26 -y

# Installing Emacs init script
rm -fr .emacs.d
sudo mv StartupConfig/.emacs.d/ ./
mkdir .emacs.d/elpa
mkdir .emacs.d/elpa/gnupg
sudo chmod 700 .emacs.d/elpa
sudo chmod 700 .emacs.d/elpa/gnupg
gpg --homedir ~/.emacs.d/elpa/gnupg --keyserver keyserver.ubuntu.com --recv-keys 066DAFCB81E42C40
sudo rm -fr restclient.el
git clone https://github.com/pashky/restclient.el.git
sudo mv restclient.el/restclient.el .emacs.d/
sudo mv restclient.el/restclient-helm.el .emacs.d/

# Installing Haskell
sudo apt install ghc
curl -sSL https://get.haskellstack.org/ | sh

# Installing Java
sudo apt install openjdk-8-jre-headless

# Installing Metals
curl -L -o coursier https://git.io/coursier
chmod +x coursier
sudo ./coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=emacs \
  org.scalameta:metals_2.12:0.8.0 \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-emacs -f

# Installing SBT
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt

# Installing Terraform
sudo unzip StartupConfig/terraform_0.12.10_linux_amd64.zip
sudo mv terraform /usr/local/bin/terraform
export PATH=$PATH:/usr/local/bin/terraform

# Installing Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 

# Installing Cmake
sudo apt-get install cmake

# Installing Fish
sudo apt-get install fish

# Installing vivaldi
wget -qO- http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository "deb [arch=i386,amd64] http://repo.vivaldi.com/stable/deb/ stable main"
sudo apt-get update
sudo apt install vivaldi-stable

# Adding Drone CLI
curl -L https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz | tar zx
sudo install -t /usr/local/bin drone

# Installing OpenDyslexia Font
sudo apt-get install fonts-opendyslexia

# Installing minikube
sudo apt install libvirt-clients
sudo apt install virt-manager
virt-host-validate
mkdir minikube
cd minkikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_1.6.2.deb \
 && sudo dpkg -i minikube_1.6.2.deb
cd ..

# Installing kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Installing Google Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk

# Installing DB stuff
sudo apt install postgresql-client-common
sudo apt install leiningen
