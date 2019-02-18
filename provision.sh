#!/bin/sh
echo '=========> It begins building [provision.sh]'
echo '=========> yum update (check current CentOS yum state)'
sudo yum update -y

# user add
useradd laravel -g wheel
mkdir -p /home/laravel/.ssh
install /vagrant/etc_sudoers-d_wheel /etc/sudoers.d/wheel -m 440
chown -R laravel:wheel /home/laravel/.ssh
mkdir -p /home/vagrant/.ssh

# install ansible server
echo '=========> certificate update'
sudo yum upgrade -y ca-certificates
echo '=========> python install'
yum install -y --nogpgcheck libselinux-python
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
echo '=========> install and execute ansible '
sudo yum install -y ansible
sudo cp /vagrant/etc_ansible_hosts /etc/ansible/hosts
sudo cp /vagrant/etc_ansible_ansible-cfg /etc/ansible/ansible.cfg

# run ansible play book
echo '=========> ansible execution'
ansible-playbook /vagrant/playbook/local/provision.yml --sudo -u vagrant
ansible-playbook /vagrant/playbook/local/sync.yml -u laravel

# restart httpd 
sudo service httpd restart
