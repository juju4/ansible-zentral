[![Build Status - Master](https://travis-ci.org/juju4/ansible-zentral.svg?branch=master)](https://travis-ci.org/juju4/ansible-zentral)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-zentral.svg?branch=devel)](https://travis-ci.org/juju4/ansible-zentral/branches)
# Zentral ansible role

Ansible role to setup zentral, framework to gather, process, and monitor system events and link them to an inventory.
https://github.com/zentralopensource/zentral/
It leverages tools like facebook osquery, google santa.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.2
 * 2.5

### Operating systems

Ubuntu 16.04, 18.04 and Centos7
Zentral requires Postgresql 9.4+ and ELKv5 which implies Java8+.

## Example Playbook

Just include this role in your list.
For example

```
- hosts: all
  roles:
    - juju4.zentral
```

## Variables

Nothing specific for now.

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.zentral
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.zentral/test/vagrant
$ vagrant up
$ vagrant ssh
```

Role has also a packer config which allows to create image for virtualbox, vmware, eventually digitalocean, lxc and others.
When building it, it's advise to do it outside of roles directory as all the directory is upload to the box during building 
and it's currently not possible to exclude packer directory from it (https://github.com/mitchellh/packer/issues/1811)
```
$ cd /path/to/packer-build
$ cp -Rd /path/to/juju4.zentral/packer .
## update packer-*.json with your current absolute ansible role path for the main role
## you can add additional role dependencies inside setup-roles.sh
$ cd packer
$ packer build packer-*.json
$ packer build -only=virtualbox-iso packer-*.json
## if you want to enable extra log
$ PACKER_LOG_PATH="packerlog.txt" PACKER_LOG=1 packer build packer-*.json
## for digitalocean build, you need to export TOKEN in environment.
##  update json config on your setup and region.
$ export DO_TOKEN=xxx
$ packer build -only=digitalocean packer-*.json
```

## Troubleshooting & Known issues

* Zentral requires postgres >= 9.4 for jsonb type.
Default Centos7 has 9.2, Trusty has 9.3 and Xenial 9.5.

* Ubuntu 18.04/Postgresql 10 requires [ansible 2.6](https://github.com/ansible/ansible/issues/25823) so user creation set with encrypted=yes (still failing).

## License

BSD 2-clause

