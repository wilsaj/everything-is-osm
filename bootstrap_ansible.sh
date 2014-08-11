#!/bin/sh
#
# small script that bootstraps execution of ansible playbooks, for the benefit
# of windows users

# install ansible
apt-get -y install ansible

# set things up so root can do key-based ssh (no password prompt) to
# vagrant@localhost
rm /root/.ssh/id_rsa
ssh-keygen -f /root/.ssh/id_rsa -P ""
cat /root/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
ssh-keyscan localhost > /root/.ssh/known_hosts

# run the ansible playbook to start making things osm
ansible-playbook -i /vagrant/vagrant_ansible_hosts -u vagrant /vagrant/osm.yml
