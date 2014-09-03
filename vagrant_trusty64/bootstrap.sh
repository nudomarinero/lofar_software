#!/usr/bin/env bash

###################
# trusty64        #
###################

## Update
apt-get update
apt-get upgrade -y

## Install dependencies
apt-get install -y gfortran cmake scons fftw3-dev flex libreadline-dev libcfitsio3 \
libcfitsio3-dev libxml2-dev libpng-dev libblas-dev liblapack-dev bison libboost-all-dev \
f2c zlib1g-dev subversion libfreetype6-dev make libncurses5-dev git libatlas-base-dev \
wcslib-dev hdf5-tools libhdf5-dev libhdf5-serial-dev build-essential libzmq-dev \
liblzo2-dev valgrind libssh2-1-dev libblitz0-dev autogen libpqxx3-dev libpq-dev \
libunittest++-dev liblog4cplus-dev libgsl0-dev xvfb

## Casacore
apt-add-repository -y ppa:jsm-8/lofar-deps
apt-get update
apt-get install -y casacore libcasacore-dev


# ## Install Python packages
apt-get install -y ipython python-matplotlib python-matplotlib-data python-pip \
python-pyfits python-numpy python-scipy python-virtualenv python-sphinx \
python-pygments python-jinja2 python-nose python-tornado cython python-zmq \
python-pywcs python-astropy python-numexpr python-tables python-pandas \
ipython-notebook ipython-qtconsole


# # ## Install updated Python packages (optional)
# apt-get build-dep -y python-matplotlib python-pyfits python-numpy python-scipy \
# ipython 
# 
# pip install --upgrade readline
# pip install --upgrade jinja2
# pip install --upgrade pygments
# pip install --upgrade sphinx
# pip install --upgrade nose
# pip install --upgrade tornado
# # Cython does not compile with 1 GB of RAM
# pip install --upgrade cython
# pip install --upgrade pyzmq 
# pip install --upgrade numpy
# pip install --upgrade scipy
# pip install --upgrade pyfits
# pip install --upgrade matplotlib
# pip install --upgrade astropy
# pip install --upgrade pywcs
# pip install --upgrade numexpr
# pip install --upgrade tables
# pip install --upgrade pandas
# pip install --upgrade ipython

## pyrap
apt-get install -y python-pyrap

## casarest
apt-get install -y casarest libcasarest-dev

## Casapy or casacore-data
apt-get install -y casacore-data

## LOFAR

## Update configuration files
