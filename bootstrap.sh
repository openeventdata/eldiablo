#!/usr/bin/env bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' |
tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update

echo "Installing base packages..."
sudo apt-get install git <<-EOF
yes
EOF
sudo apt-get install g++ <<-EOF
yes
EOF
sudo apt-get install libncurses5-dev <<-EOF
yes
EOF
sudo apt-get install make
sudo apt-get install zip
sudo apt-get install unzip
sudo apt-get install libxml2-dev <<-EOF
yes
EOF
sudo apt-get install libxslt1-dev <<-EOF
yes
EOF
sudo apt-get install python-dev <<-EOF
yes
EOF
sudo apt-get install python-pip <<-EOF
yes
EOF

echo "Cloning Phoenix pipeline files..."
sudo git clone https://github.com/openeventdata/phoenix_pipeline.git
sudo git clone https://github.com/openeventdata/scraper.git

echo "Installing Python dependencies..."
sudo pip install -r scraper/requirements.txt
sudo pip install -r phoenix_pipeline/requirements.txt

echo "Download and compile TABARI..."
wget http://eventdata.parusanalytics.com/tabari.dir/TABARI.0.8.4b2.make.dir.zip
unzip TABARI.0.8.4b2.make.dir.zip
cd TABARI.0.8.4b2.make.dir/
echo "Compiling TABARI..."
sudo make
sudo make
echo "Moving TABARI to phoenix_pipeline..."
sudo mv TABARI.0.8.4b2 ../phoenix_pipeline/
cd


echo "Downloading NLTK data..."
sudo mkdir -p nltk_data/tokenizers
cd nltk_data/tokenizers
sudo wget http://www.nltk.org/nltk_data/packages/tokenizers/punkt.zip
sudo unzip punkt.zip
cd
sudo mv nltk_data /usr/lib/nltk_data

echo "Installing MongoDB..."
sudo apt-get install mongodb-10gen

echo "Setting up crontab..."
sudo crontab /vagrant/crontab.txt
