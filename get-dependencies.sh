#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat_epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat_epel
#[ ! -d $rolesdir/geerlingguy.postgresql ] && git clone https://github.com/geerlingguy/ansible-role-postgresql $rolesdir/geerlingguy.postgresql
[ ! -d $rolesdir/geerlingguy.postgresql ] && git clone https://github.com/juju4/ansible-role-postgresql $rolesdir/geerlingguy.postgresql
[ ! -d $rolesdir/geerlingguy.redis ] && git clone https://github.com/juju4/ansible-role-redis.git $rolesdir/geerlingguy.redis
[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/juju4/ansible-role-java.git $rolesdir/geerlingguy.java
[ ! -d $rolesdir/Mayeu.RabbitMQ ] && git clone https://github.com/juju4/ansible-playbook-rabbitmq.git $rolesdir/Mayeu.RabbitMQ
## getting v5 roles
[ ! -d $rolesdir/geerlingguy.elasticsearch ] && git clone https://github.com/juju4/ansible-role-elasticsearch.git $rolesdir/geerlingguy.elasticsearch
[ ! -d $rolesdir/geerlingguy.logstash ] && git clone https://github.com/juju4/ansible-role-logstash.git $rolesdir/geerlingguy.logstash
[ ! -d $rolesdir/geerlingguy.kibana ] && git clone https://github.com/juju4/ansible-role-kibana.git $rolesdir/geerlingguy.kibana
[ ! -d $rolesdir/geerlingguy.nginx ] && git clone https://github.com/geerlingguy/ansible-role-nginx.git $rolesdir/geerlingguy.nginx
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.zentral ] && ln -s ansible-zentral $rolesdir/juju4.zentral
[ ! -e $rolesdir/juju4.zentral ] && cp -R $rolesdir/ansible-zentral $rolesdir/juju4.zentral

## don't stop build on this script return code
true

