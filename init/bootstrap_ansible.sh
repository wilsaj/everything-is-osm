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


# Ansible requires that an inventory file is not executable, so copy ansible
# hosts file to /tmp and change permissions. This is necessary on Windows due to
# the way filesystems are implemented: there isn't a way to change per-file
# permissions on files in the shared /vagrant dir.
cp /vagrant/init/vagrant_ansible_hosts /tmp/vagrant_ansible_hosts
chmod -x /tmp/vagrant_ansible_hosts


# set PYTHONUNBUFFERED env variable so output from the ansible script is passed
# along in real time instead of all flushed at the very end
export PYTHONUNBUFFERED=1

# run the ansible playbook to start making things osm
ansible-playbook -i /tmp/vagrant_ansible_hosts -u vagrant /vagrant/ansible/everything-is-osm.yml
