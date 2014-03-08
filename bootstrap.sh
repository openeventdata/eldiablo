#!/usr/bin/env bash

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' |
tee /etc/apt/sources.list.d/mongodb.list
apt-get update

echo "\nInstalling base packages...\n"
apt-get install git <<-EOF
yes
EOF
apt-get install unzip
apt-get install libxml2-dev <<-EOF
yes
EOF
apt-get install libxslt1-dev <<-EOF
yes
EOF
apt-get install python-dev <<-EOF
yes
EOF
apt-get install python-pip <<-EOF
yes
EOF

echo "\nCloning Phoenix pipeline files...\n"
git clone https://github.com/openeventdata/phoenix_pipeline.git
git clone https://github.com/openeventdata/scraper.git

echo "\nInstalling Python dependencies...\n"
pip install -r scraper/requirements.txt

echo "\nDownloading NLTK data...\n"
mkdir -p nltk_data/tokenizers
cd nltk_data/tokenizers
wget http://nltk.github.com/nltk_data/packages/tokenizers/punkt.zip
unzip punkt.zip
cd

echo "\nInstalling MongoDB...\n"
apt-get install mongodb-10gen
