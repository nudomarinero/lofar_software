
LOFAR software
==============

Intallation of LOFAR software in vagrant boxes
----------------------------------------------

At the moment we are testing the installation of the LOFAR software on Debian and Ubuntu. The software is installed on fresh boxes of the operating systems using vagrant.

Versions tested:
  * Ubuntu 12.04 LTS
  * Ubuntu 14.04 LTS

Versions under development:
  * Centos 5.8 (development suspended)
  * Debian Wheezy (development suspended)
  * Debian Jessie (not working yet)

Creation of the Virtual Machine
-------------------------------

The first step is to enter the directory of our selected Virtual Machine (VM):
```
cd vagrant_precise64
```

Launch the VM:
```
vagrant up
```
During this process the dependencies will be installed. The script ```bootstrap.sh``` is run and the software installed.

After the installation process, if everything is all right, you will be able lo login to the new VM using:
```
vagrant ssh
```

Packaging of the VM
-------------------

After the setup of the VM it is possible to package it and its environment using the command: 
```
vagrant package --vagrantfile Vagrantfile.pkg
```


