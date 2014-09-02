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
wcslib-dev hdf5-tools libhdf5-dev libhdf5-serial-dev build-essential

## Casacore



# ## Install Python dependencies
# apt-get install -y ipython python-matplotlib python-matplotlib-data python-pip \
# python-pyfits python-numpy python-scipy python-virtualenv
# 
# ## Install updated Python packages
# pip install --upgrade numpy
# pip install --upgrade scipy
# pip install --upgrade pyfits
# pip install --upgrade matplotlib
# pip install --upgrade pywcs

## pyrap

## casarest

## Casapy or casacore-data

## LOFAR

## Update configuration files
