#!/usr/bin/env bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' |
tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update

echo "\nInstalling base packages...\n"
sudo apt-get install git <<-EOF
yes
EOF
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

echo "\nCloning Phoenix pipeline files...\n"
sudo git clone https://github.com/openeventdata/phoenix_pipeline.git
sudo git clone https://github.com/openeventdata/scraper.git

echo "\nInstalling Python dependencies...\n"
sudo pip install -r scraper/requirements.txt

echo "\nDownloading NLTK data...\n"
mkdir -p nltk_data/tokenizers
cd nltk_data/tokenizers
wget http://nltk.github.com/nltk_data/packages/tokenizers/punkt.zip
sudo unzip punkt.zip
cd

echo "\nInstalling MongoDB...\n"
sudo apt-get install mongodb-10gen
