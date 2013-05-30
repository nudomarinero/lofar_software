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
cd

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
    -DHDF5_ROOT_DIR=/usr/local/hdf5 -DLIB_EXTRA_SYNTHESIS=gfortran -DBUILD_ALL=1
make
make install

## Monetdb
cp /vagrant/monetdb.list /etc/apt/sources.list.d/
wget --output-document=- http://dev.monetdb.org/downloads/MonetDB-GPG-KEY | sudo apt-key add -
apt-get update
apt-get install -y monetdb5-sql monetdb-client
usermod -a -G monetdb vagrant
# Activate the database at startup
cp /vagrant/monetdb5-sql /etc/default/monetdb5-sql
# Activate the database now
/etc/init.d/monetdb5-sql start


## healpy
# pip install --upgrade healpy

## Casapy
apt-get install -y libgsl0-dev xvfb
cd
wget https://svn.cv.nrao.edu/casa/linux_distro/stable/casapy-stable-41.0.23375-001-64b.tar.gz
tar xfz casapy-stable-41.0.23375-001-64b.tar.gz
cd casapy-stable-41.0.23375-001-64b
mv casapy-stable-41.0.23375-001-64b /opt
ln -s /opt/casapy-stable-41.0.23375-001-64b /opt/casa
# export PATH=$PATH:/opt/casa


#### LOFAR ####
## Dependencies
# liblog4cxx10-dev liblog4cpp5-dev
# massif-visualizer?
apt-get install -y valgrind libssh2-1-dev libblitz0-dev autogen libpqxx3-dev libpq-dev \
libunittest++-dev 

#apt-get install -y nvidia-cuda-dev

## DAL
cd
#wget --trust-server-name http://downloads.sourceforge.net/project/dall/src/DAL-2.0.32.src.tar.gz\?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fdall%2Ffiles%2Fsrc%2F\&ts=1369948556\&use_mirror=switch
wget --trust-server-name http://downloads.sourceforge.net/project/dall/DAL-2.0.32.tar.gz\?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fdall%2Ffiles%2F%3Fsource%3Dnavbar\&ts=1369948918\&use_mirror=switch
tar xfz DAL-2.0.32.tar.gz
mv DAL-2.0.32 /opt


## LOFAR
cd
#svn co https://svn.astron.nl/LOFAR/trunk LOFAR
cp -r /vagrant/LOFAR .
cd LOFAR
./CMake/gen_LofarPackageList_cmake.sh
mkdir -p build/gnu_opt; cd build/gnu_opt
mkdir /opt/LofIm
export LD_LIBRARY_PATH=/usr/local/hdf5/lib:$LD_LIBRARY_PATH
cmake ../.. -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/opt/LofIm \
      -DUSE_LOG4CPLUS=OFF -DHDF5_LIBRARIES=/usr/local/hdf5/lib/libhdf5.so \
      -DHDF5_INCLUDE_DIRS=/usr/local/hdf5/include \
      -DDAL_LIBRARY=/opt/DAL-2.0.32/lib -DDAL_INCLUDE_DIR=/opt/DAL-2.0.32/inc \
      -DFFTW3_LIBRARIES=/usr/lib/libfftw3f_threads.so\;/usr/lib/libfftw3_threads.so\;\
/usr/lib/libfftw3f.so\;/usr/lib/libfftw3.so \
      -DCASACORE_ROOT_DIR=/usr/local/ -DCASACORE_INCLUDE_DIR=/usr/local/include/casacore \
      -DUSE_OPENMP=ON \
      -DBUILD_PACKAGES=Offline\;LofarFT\;StaticMetaData\;SPW_Combine
make
make install

## Update configuration files
cat /vagrant/bashrc >> /home/vagrant/.bashrc
cp /vagrant/casarc /home/vagrant/.casarc

## Clean
# Manually at the moment
#rm -r casarest casacore-1.5.0 hdf5-1.8.10-patch1 LOFAR pyrap-1.1.0
#rm -r wcslib-4.17 
#rm casapy-stable-41.0.23375-001-64b.tar.gz
#rm hdf5-1.8.10-patch1.tar.gz
#rm wcslib.tar.bz2
#rm -r wcslib-4.17 

