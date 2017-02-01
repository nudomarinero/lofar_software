Vagrant
=======

Test the instalation of LOFAR dependencies in Ubuntu 16.04 LTS

The provison file called by vagrant is provision.yml.

To start and provision a VM use:
```vagrant up```

If the VMm is up and you would like to run only Ansible use:
```vagrant provision```

To completely remove the VM use:
```vagrant destroy```

When the base box, in this case Ubuntu 14.04 LTS, gets outdated, it 
is possible to update it with:
```vagrant box update```