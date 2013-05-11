#!/usr/bin/env bash

###################
# debian_wheezy   #
###################

## Update
apt-get update

## Upgrade
#apt-get upgrade -y
# Not tested

## Install dependencies
apt-get install -y gfortran cmake scons fftw3-dev flex libreadline-dev libcfitsio3 libcfitsio3-dev libxml2-dev libpng-dev libblas-dev liblapack-dev bison libboost-all-dev f2c zlib1g-dev subversion libfreetype6-dev make libncurses5-dev

## wcs library
cd
wget ftp://ftp.atnf.csiro.au/pub/software/wcslib/wcslib.tar.bz2
tar xfj wcslib.tar.bz2
cd wcslib-4.17
./configure
make
mkdir -p /usr/local/share/man/man1
make install
cd ..
#rm -rf wcslib-4.17
#rm wcslib.tar.bz2

## hdf5
#apt-get install -y libhdf5-openmpi-dev 
# Non thread safe. Is this a problem for casacore?
apt-get install -y libhdf5-serial-dev

## Casacore
cd
svn co http://casacore.googlecode.com/svn/tags/casacore-1.5.0
cd casacore-1.5.0
patch -p1 < /vagrant/casacore.patch
mkdir build; cd build
#cmake .. -DUSE_HDF5=ON -DUSE_FFTW3=ON -DHDF5_INCLUDE_DIRS=/usr/lib/openmpi/include
cmake .. -DUSE_HDF5=ON -DUSE_FFTW3=ON  
make
make install


