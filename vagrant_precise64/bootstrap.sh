#!/usr/bin/env bash

###################
# precise64       #
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
#apt-get install -y openmpi-bin libopenmpi-dev 
wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.10-patch1.tar.gz
tar xfz hdf5-1.8.10-patch1.tar.gz
cd hdf5-1.8.10-patch1
mkdir build; cd build
# parallel

#CPPFLAGS=-I/usr/lib/openmpi/include \
#LDFLAGS=-L/usr/lib/openmpi/lib \
#../configure \
#--enable-production --enable-threadsafe --enable-parallel \
#--prefix=/usr/local/hdf5
#
#CC=/usr/local/mpi/bin/mpicc make ??

# serial
../configure --enable-production --enable-threadsafe --with-pthread --prefix=/usr/local/hdf5
make
#make check
sudo make install
#sudo make check-install


## Casacore
cd
svn co http://casacore.googlecode.com/svn/tags/casacore-1.5.0
cd casacore-1.5.0
mkdir build; cd build
cmake .. -DUSE_HDF5=ON -DUSE_FFTW3=ON -DHDF5_ROOT_DIR=/usr/local/hdf5
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
svn co https://svn.astron.nl/casarest/trunk/casarest/
cd casarest
mkdir build; cd build
cmake .. -DCASACORE_ROOT_DIR=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local \
         -DLIB_EXTRA_SYNTHESIS=gfortran -DBUILD_ALL=1
make
make install

## Monetdb
cp /vagrant/monetdb.list /etc/apt/sources.list.d/
wget --output-document=- http://dev.monetdb.org/downloads/MonetDB-GPG-KEY | sudo apt-key add -
apt-get update
apt-get install monetdb5-sql monetdb-client
usermod -a -G monetdb vagrant


