#!/bin/bash

APULL="$(which ansible-pull)"
MYREPO="https://github.com/computerfr33k/fedora_workstation_builder.git"

# Bootstrap Ansible
if rpm -q ansible
then
    echo "Ansible already installed"
else
    sudo dnf install -y ansible git
    APULL="$(which ansible-pull)"
fi

if [ ! -f $HOME/.ansible.cfg ]; then
    touch $HOME/.ansible.cfg
    echo '[defaults]' >$HOME/.ansible.cfg
    echo 'remote_tmp     = /tmp/$USER/ansible' >>$HOME/.ansible.cfg
fi

sudo $APULL -U $MYREPO