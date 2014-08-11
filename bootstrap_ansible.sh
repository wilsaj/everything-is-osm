#!/bin/sh
#
# small script that bootstraps execution of ansible playbooks, for the benefit
# of windows users

apt-get -y install ansible

# write id file
rm /root/.ssh/id_rsa
ssh-keygen -f /root/.ssh/id_rsa -P ""

cat /root/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
ssh-keyscan localhost > /root/.ssh/known_hosts

ansible-playbook -i /vagrant/vagrant_ansible_hosts -u vagrant /vagrant/osm.yml
