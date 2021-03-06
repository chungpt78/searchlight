#!/bin/bash -xe

# This script will be run by OpenStack CI before unit tests are run,
# it sets up the test system as needed.
# Developer should setup their test systems in a similar way.

# This setup needs to be run by a user that can run sudo.

sudo apt-get update
. /etc/os-release
if [[ $VERSION_CODENAME = bionic ]]; then
    sudo apt-get install -y openjdk-8-jre
else
    sudo apt-get install -y default-jre
fi

ELASTICSEARCH_MAJOR_VERSION=${ELASTICSEARCH_MAJOR_VERSION:"2"}
if [[ "$ELASTICSEARCH_MAJOR_VERSION" == "5" ]]; then
  echo "Downloading and installing elasticsearch 5.6.11"
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.11.deb
  sudo dpkg -i elasticsearch-5.6.11.deb
else
  echo "Downloading and installing elasticsearch 2.3.4"
  wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.4/elasticsearch-2.3.4.deb
  sudo dpkg -i elasticsearch-2.3.4.deb
fi
# Make 'elasticsearch' binary callable from within functional tests
sudo ln -s /usr/share/elasticsearch/bin/elasticsearch /usr/local/bin/elasticsearch
