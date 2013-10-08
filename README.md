
LOFAR software
==============

Intallation of LOFAR software in vagrant boxes
----------------------------------------------

At the moment we are testing the installation of the LOFAR software on Debian and Ubuntu. The software is installed on fresh boxes of the operating systems using vagrant.

Versions tested:
  * Ubuntu 12.04 LTS
  * Debian Wheezy (not working yet)
  * Ubuntu 12.10 (not working yet)

Creation of the Virtual Machine
-------------------------------

The first step is to enter the directory of our selected Virtual Machine (VM):
```
cd vagrant_precise64
```

We need to check out the LOFAR software to the base directory using our credentials:
```
svn co https://svn.astron.nl/LOFAR/trunk LOFAR
```

Now we can launch the VM:
```
vagrant up
```
During this process, that can take several hours, the dependencies will be installed and compiled. The script ```bootstrap.sh``` is run and the software installed.

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


