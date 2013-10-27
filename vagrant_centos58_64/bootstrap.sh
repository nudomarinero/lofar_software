#!/usr/bin/env bash
###################
# centos 5.8 64   #
###################

## Update
yum check-update
## Upgrade (-y option?)
yum -y upgrade


## Install dependencies
#apt-get install -y gfortran cmake scons fftw3-dev flex libreadline-dev libcfitsio3 \
#libcfitsio3-dev libxml2-dev libpng-dev libblas-dev liblapack-dev bison libboost-all-dev \
#f2c zlib1g-dev subversion libfreetype6-dev make libncurses5-dev git libatlas-base-dev

yum -y install boost-devel.x86_64 fftw3-devel.x86_64 cmake.x86_64 \
    scons.noarch readline-devel.x86_64 libxml2-devel.x86_64 \
    hdf5-devel.x86_64 libpng-devel.x86_64 blas-devel.x86_64 \
    lapack-devel.x86_64 compat-libf2c-34.x86_64 ncurses-devel.x86_64 \
    freetype-devel.x86_64 atlas-c++-devel.x86_64 cmake.x86_64 \
    valgrind-devel.x86_64 libssh2-devel.x86_64 libpqxx-devel.x86_64 \
    gcc-gfortran.x86_64 libgfortran.x86_64 screen.x86_64

yum -y install libtar-devel.x86_64 bzip2-devel.x86_64 libzip-devel.x86_64

## cfitsio
cd /home/vagrant
wget ftp://heasarc.gsfc.nasa.gov/software/fitsio/c/cfitsio3350.tar.gz
tar xfz cfitsio3350.tar.gz
cd cfitsio
./configure --prefix=/usr/local
make
make install

## wcs library
cd /home/vagrant
wget ftp://ftp.atnf.csiro.au/pub/software/wcslib/wcslib.tar.bz2
tar xfj wcslib.tar.bz2
cd wcslib-4.19
./configure
make
make install

## hdf5 (from source) ??

## zeromq
cd /home/vagrant
wget http://download.zeromq.org/zeromq-3.2.4.tar.gz
tar xzf zeromq-3.2.4.tar.gz
cd zeromq-3.2.4
./configure
make
make install

## Python
cd /home/vagrant
wget http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz
tar xfz Python-2.7.5.tgz
cd Python-2.7.5
unset PYTHONPATH
unset PYTHONHOME
./configure --enable-shared
make
make install
export LD_LIBRARY_PATH=/usr/local/lib
#export PYTHONPATH=/usr/lib/python2.7/site-packages

## Update paths
/usr/bin/install -c -m 644 /vagrant/local_profile.csh /etc/profile.d/local.csh
/usr/bin/install -c -m 644 /vagrant/local_profile.sh /etc/profile.d/local.sh
# TODO: Check if the following lines work
/usr/bin/install -c -m 644 /vagrant/local_ld_so_conf /etc/ld.so.conf.d/local.conf
ldconfig

# Python easy_install and pip
cd /home/vagrant
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
pip install pywcs
pip install astropy

# pyzmq
cd /home/vagrant
wget https://pypi.python.org/packages/source/p/pyzmq/pyzmq-13.0.2.tar.gz --no-check-certificate
tar xzf pyzmq-13.0.2.tar.gz
cd pyzmq-13.0.2
python setup.py configure --zmq=/usr/local/
python setup.py install

# IPython
pip install ipython[all]

## Casacore

cd casacore-1.5.0
mkdir build; cd build
cmake .. -DWCSLIB_LIBRARY=/home/users/dae/jsm/local/lib/libwcs.so \
         -DWCSLIB_INCLUDE_DIR=/home/users/dae/jsm/local/include/ \
         -DCMAKE_INSTALL_PREFIX=/home/users/dae/jsm/local/casacore \
         -DUSE_HDF5=ON -DUSE_FFTW3=ON \
         -DHDF5_ROOT_DIR=/usr/local/hdf5-1.8.11-linux-x86_64-shared \
         -DLAPACK_LIBRARIES=/home/users/dae/jsm/local/atlas/lib/liblapack.a \
         -DBLAS_LIBRARIES=/home/users/dae/jsm/local/atlas/lib/libf77blas.a\;/home/users/dae/jsm/local/atlas/lib/libcblas.a\;/home/users/dae/jsm/local/atlas/lib/libatlas.a \
         -DBLA_VENDOR=ATLAS \
         -DFFTW3_LIBRARY=/home/users/dae/jsm/local/lib/libfftw3.so \
         -DFFTW3_THREADS_LIBRARY=/home/users/dae/jsm/local/lib/libfftw3_threads.so \
         -DFFTW3F_LIBRARY=/home/users/dae/jsm/local/lib/libfftw3f.so \
         -DFFTW3F_THREADS_LIBRARY=/home/users/dae/jsm/local/lib/libfftw3f_threads.so \
         -DFFTW3_INCLUDE=/home/users/dae/jsm/local/include/ \
         -DCMAKE_Fortran_COMPILER:FILEPATH=/usr/bin/gfortran

## Install Python dependencies

wget http://download.zeromq.org/zeromq-3.2.4.tar.gz

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
rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
yum install -y kernel-devel kernel-headers dkms
KERN_DIR=/usr/src/kernels/`uname -r`-`uname -m`
export KERN_DIR


## Clean cache
# apt-get clean

