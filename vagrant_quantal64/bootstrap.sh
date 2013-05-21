#!/usr/bin/env bash

###################
# quantal64       #
###################

## Update
apt-get update

## Upgrade
# apt-get upgrade -y
# Possible problem with grub?

## Install dependencies
apt-get install -y gfortran cmake scons fftw3-dev flex libreadline-dev libcfitsio3 \
libcfitsio3-dev libxml2-dev libpng-dev libblas-dev liblapack-dev bison libboost-all-dev \
f2c zlib1g-dev subversion libfreetype6-dev make libncurses5-dev git

## wcs library
apt-get install -y wcslib-dev

## hdf5
apt-get install -y libhdf5-serial-dev 
#apt-get install -y openmpi-bin libopenmpi-dev 

## Casacore
cd
svn co http://casacore.googlecode.com/svn/tags/casacore-1.5.0
cd casacore-1.5.0
patch -p1 < /vagrant/casacore.patch
mkdir build; cd build
cmake .. -DUSE_HDF5=ON -DUSE_FFTW3=ON
make
make install

## Install Python dependencies
apt-get install -y ipython python-matplotlib python-matplotlib-data python-pip \
 python-pyfits python-numpy python-scipy python-virtualenv

## Install updated Python packages
pip install --upgrade numpy
pip install --upgrade scipy
pip install --upgrade pyfits
pip install --upgrade matplotlib

## pywcs
pip install --upgrade pywcs

## pyrap
cd
svn co http://pyrap.googlecode.com/svn/tags/pyrap-1.1.0
cd pyrap-1.1.0
python batchbuild.py

## casarest
cd
#svn co https://svn.astron.nl/casarest/trunk/casarest/
mkdir build; cd build
cmake .. -DCASACORE_ROOT_DIR=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local \
         -DLIB_EXTRA_SYNTHESIS=gfortran -DBUILD_ALL=1
make

