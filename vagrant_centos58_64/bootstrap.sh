#!/usr/bin/env bash
###################
# centos 5.8 64   #
###################

## Update

## Upgrade

## Install dependencies
#apt-get install -y gfortran cmake scons fftw3-dev flex libreadline-dev libcfitsio3 \
#libcfitsio3-dev libxml2-dev libpng-dev libblas-dev liblapack-dev bison libboost-all-dev \
#f2c zlib1g-dev subversion libfreetype6-dev make libncurses5-dev git libatlas-base-dev

## wcs library

## hdf5 (from source)

## Casacore


## Install Python dependencies
#apt-get install -y ipython python-matplotlib python-matplotlib-data python-pip \
#python-pyfits python-numpy python-scipy python-virtualenv

## Install updated Python packages
#pip install --upgrade numpy
#pip install --upgrade scipy
#pip install --upgrade pyfits
#pip install --upgrade matplotlib

## pywcs
#pip install --upgrade pywcs

## pyrap

## casarest

## Monetdb ?

## healpy

## Casapy

#### LOFAR ####
# apt-get install -y valgrind libssh2-1-dev libblitz0-dev autogen libpqxx3-dev libpq-dev \
# libunittest++-dev
#apt-get install -y nvidia-cuda-dev

## DAL ?

## LOFAR


## Update configuration files
#cat /vagrant/bashrc >> /home/vagrant/.bashrc
#cp /vagrant/casarc /home/vagrant/.casarc
#chown vagrant:vagrant /home/vagrant/.casarc

##Optionally install ipython-notebook and qtconsole
#apt-get install -y ipython-notebook ipython-qtconsole
#pip install --upgrade ipython

### Before packaging
## Manually at the moment

## Clean
#rm -r casarest casacore-1.5.0 hdf5-1.8.11 LOFAR pyrap-1.1.0
#rm casapy-stable-41.0.23375-001-64b.tar.gz
#rm hdf5-1.8.11.tar.gz
#rm DAL-2.0.32.tar.gz


## Upgrade
# apt-get update
# apt-get upgrade -y
## Problem with grub. Manually select the first partition

## Upload the VirtualBox kernel modules
# /etc/init.d/vboxadd setup

## Clean cache
# apt-get clean

