#!/bin/sh
#
# small script that bootstraps execution of ansible playbooks, for the benefit
# of windows users

# install ansible
apt-get -y install ansible

# set things up so root can do key-based ssh (no password prompt) to
# vagrant@localhost
rm -f /root/.ssh/id_rsa*
ssh-keygen -f /root/.ssh/id_rsa -P ""
cat /root/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
ssh-keyscan localhost > /root/.ssh/known_hosts


# Ansible needs to have host file not be executable, so copy ansible hosts file
# to /tmp so we can change permissions if VM host is Windows (permissions are
# editable or even a thing that exists on Windows filesystems).
cp /vagrant/vagrant_ansible_hosts /tmp/vagrant_ansible_hosts
chmod -x /tmp/vagrant_ansible_hosts

# run the ansible playbook to start making things osm
ansible-playbook -i /tmp/vagrant_ansible_hosts -u vagrant /vagrant/osm.yml
