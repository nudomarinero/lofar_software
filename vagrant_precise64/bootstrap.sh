#!/usr/bin/env bash

###################
# precise64       #
###################

## Update
apt-get update
## Upgrade
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

## Install dependencies
apt-get install -y gfortran cmake scons fftw3-dev flex libreadline-dev libcfitsio3 \
libcfitsio3-dev libxml2-dev libpng-dev libblas-dev liblapack-dev bison libboost-all-dev \
f2c zlib1g-dev subversion libfreetype6-dev make libncurses5-dev git libatlas-base-dev \
wcslib-dev python-software-properties software-properties-common hdf5-tools \
libhdf5-serial-dev


## ska repo
apt-add-repository -y ppa:ska-sa/main
apt-get update
apt-get install -y python-pyrap casacore libcasacore-dev casacore-data lwimager

## Install Python dependencies
# ## Install Python packages
apt-get install -y ipython python-matplotlib python-matplotlib-data python-pip \
python-pyfits python-numpy python-scipy python-virtualenv python-sphinx \
python-pygments python-jinja2 python-nose python-tornado cython python-zmq \
python-pywcs python-numexpr python-tables python-pandas \
ipython-notebook ipython-qtconsole
# apt-get install -y ipython python-matplotlib python-matplotlib-data python-pip \
# python-pyfits python-numpy python-scipy python-virtualenv

## Install updated Python packages
#pip install --upgrade numpy
#pip install --upgrade scipy
#pip install --upgrade pyfits
#pip install --upgrade matplotlib

## pywcs
#pip install --upgrade pywcs


## Casapy
# apt-get install -y libgsl0-dev xvfb
# cd
# CASAPY_VERSION=42.1.29047-001-1
# wget https://svn.cv.nrao.edu/casa/linux_distro/casapy-${CASAPY_VERSION}-64b.tar.gz
# tar xfz casapy-${CASAPY_VERSION}-64b.tar.gz
# mv casapy-${CASAPY_VERSION}-64b /opt
# ln -s /opt/casapy-${CASAPY_VERSION}-64b /opt/casa
# # export PATH=$PATH:/opt/casa

## LOFAR
apt-get install -y valgrind libssh2-1-dev libblitz0-dev autogen libpqxx3-dev libpq-dev \
libunittest++-dev liblog4cplus-dev
cd
svn co --username "lofar" --password "M_OKZZJBTNuI" --non-interactive https://svn.astron.nl/LOFAR/trunk LOFAR
cd LOFAR
mkdir -p build/gnu_opt; cd build/gnu_opt
mkdir /opt/LofIm
cmake ../.. -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_PREFIX=/opt/LofIm \
    -DUSE_OPENMP=ON \
    -DF2PY_FCOMPILER=gnu95 \
    -DBUILD_PACKAGES=Offline
make
make install
cd
rm -rf LOFAR

## Update configuration files
cat /vagrant/bashrc >> /home/vagrant/.bashrc

