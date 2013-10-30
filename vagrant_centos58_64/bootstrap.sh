#!/usr/bin/env bash
###################
# centos 5.8 64   #
###################

## Update
yum check-update
## Upgrade (-y option?)
yum -y upgrade

## Add EPEL repository
rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm

## Install dependencies
#apt-get install -y gfortran cmake scons fftw3-dev flex libreadline-dev libcfitsio3 \
#libcfitsio3-dev libxml2-dev libpng-dev libblas-dev liblapack-dev bison libboost-all-dev \
#f2c zlib1g-dev subversion libfreetype6-dev make libncurses5-dev git libatlas-base-dev

yum -y install boost-devel.x86_64 cmake.x86_64 \
    readline-devel.x86_64 libxml2-devel.x86_64 \
    hdf5-devel.x86_64 libpng-devel.x86_64 blas-devel.x86_64 \
    lapack-devel.x86_64 compat-libf2c-34.x86_64 ncurses-devel.x86_64 \
    freetype-devel.x86_64 atlas-c++-devel.x86_64 cmake.x86_64 \
    valgrind-devel.x86_64 libssh2-devel.x86_64 libpqxx-devel.x86_64 \
    gcc-gfortran.x86_64 libgfortran.x86_64 screen.x86_64 \
    libtar-devel.x86_64 bzip2-devel.x86_64 libzip-devel.x86_64


yum -y install fftw3-devel.x86_64 cfitsio-devel.x86_64 \
    libwcs-devel.x86_64 zeromq-devel.x86_64 \
    boost141-devel.x86_64


## Python
wget http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz
tar xfz Python-2.7.5.tgz
cd Python-2.7.5
unset PYTHONPATH
unset PYTHONHOME
./configure --enable-shared
make
make install
export LD_LIBRARY_PATH=/usr/local/lib
export PYTHONPATH=/usr/local/lib/python2.7/site-packages

## Update paths
/usr/bin/install -c -m 644 /vagrant/local_profile.csh /etc/profile.d/local.csh
/usr/bin/install -c -m 644 /vagrant/local_profile.sh /etc/profile.d/local.sh
# TODO: Check if the following lines work
/usr/bin/install -c -m 644 /vagrant/local_ld_so_conf /etc/ld.so.conf.d/local.conf
ldconfig

# Python easy_install and pip
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
python ez_setup.py --insecure
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
python get-pip.py

# Python packages
pip install virtualenv
pip install numpy
pip install cython
pip install h5py
pip install scipy
pip install matplotlib
pip install pandas
pip install pyfits
pip install pywcs ## NOT WORKING. TODO: CHECK
pip install astropy
pip install pyzmq
pip install ipython[all]

## Casacore
svn co http://casacore.googlecode.com/svn/tags/casacore-1.5.0
cd casacore-1.5.0
mkdir build; cd build
cmake .. -DUSE_HDF5=ON -DUSE_FFTW3=ON
make
make install

## scons
cd
wget http://prdownloads.sourceforge.net/scons/scons-2.3.0.tar.gz
tar xfz scons-2.3.0.tar.gz
cd scons-2.3.0
python setup.py install

## boost
cd
wget http://prdownloads.sourceforge.net/boost/boost/1.54.0/boost_1_54_0.tar.gz
tar xvfz boost_1_54_0.tar.gz
cd boost_1_54_0
./bootstrap.sh
./b2 link=shared
./b2 install

## pyrap
cd
svn co http://pyrap.googlecode.com/svn/tags/pyrap-1.1.0
cd pyrap-1.1.0
python batchbuild.py --python-prefix=/usr/local/lib \
--numpy-incdir=/usr/local/lib/python2.7/site-packages/numpy/core/include
python batchbuild.py --numpy-incdir=/usr/local/lib/python2.7/site-packages/numpy/core/include

## casarest
cd
svn co https://svn.astron.nl/casarest/trunk/casarest/
cd casarest
mkdir build; cd build
cmake .. -DBOOST_ROOT=/usr/local -DBUILD_ALL=1
make
make install

## ds9
cd
wget http://hea-www.harvard.edu/RD/ds9/download/linux64/ds9.linux64.7.2.tar.gz
tar zxf ds9.linux64.7.2.tar.gz
mv ds9 /usr/local/bin

## Casapy

#### LOFAR ####
# apt-get install -y valgrind libssh2-1-dev libblitz0-dev autogen libpqxx3-dev libpq-dev \
# libunittest++-dev
#apt-get install -y nvidia-cuda-dev

## log4cplus
cd 
wget http://prdownloads.sourceforge.net/log4cplus/log4cplus-stable/1.1.1/log4cplus-1.1.1.tar.gz
tar xvfz log4cplus-1.1.1.tar.gz
cd log4cplus-1.1.1
./configure
make
make install

## LOFAR
cd
cp -r /vagrant/LOFAR .
cd LOFAR
mkdir -p build/gnu_opt; cd build/gnu_opt
mkdir /opt/LofIm
cmake ../.. -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/opt/LofIm \
  -DPYTHON_INCLUDE_PATH=/usr/local/include \
  -DPYTHON_EXECUTABLE:FILEPATH=/usr/local/bin/python \
  -DF2PY_FCOMPILER=gnu95 \
  -DBUILD_PACKAGES=Offline\;LofarFT\;StaticMetaData\;SPW_Combine
make

  

# TODO: Check if the following lines work
/usr/bin/install -c -m 644 /vagrant/lofar_ld_so_conf /etc/ld.so.conf.d/lofar.conf
ldconfig

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
# yum install -y kernel-devel kernel-headers dkms
# KERN_DIR=/usr/src/kernels/`uname -r`-`uname -m`
# export KERN_DIR
# fftw3-3.2.2-3.el5.x86_64.rpm

## Clean cache
# apt-get clean

