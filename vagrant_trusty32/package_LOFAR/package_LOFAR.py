#!/usr/bin/env python
import os

### Configuration
config = {
    "source_dir" : "/vagrant/package_LOFAR",
    "version" : "2.8",
    "pkgrelease" : "1trusty"
    }
###

config["release"] = config["version"].replace(".", "_")

template_bash = """
#!/bin/bash

cd
svn co --username "lofar" --password "M_OKZZJBTNuI" --non-interactive \
https://svn.astron.nl/LOFAR/branches/LOFAR-Release-{release} LOFAR
cd LOFAR
mkdir -p build/gnu_opt; cd build/gnu_opt


mkdir /opt/LofIm-{release}
cmake ../.. -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_INSTALL_PREFIX=/opt/LofIm-{release} \
    -DUSE_OPENMP=ON \
    -DF2PY_FCOMPILER=gnu95 \
    -DBUILD_PACKAGES=Offline
make


# Prepare dependencies for checkinstall
sudo apt-get install -y checkinstall

cp {source_dir}/description-pak .
cp {source_dir}/postinstall-pak .
chmod +x postinstall-pak

sudo checkinstall -D --nodoc --install=no \
--requires="fftw3-dev,libreadline-dev,libcfitsio3,libxml2-dev,libpng-dev,libblas-dev,\
liblapack-dev,libboost-all-dev,zlib1g-dev,libfreetype6-dev,libncurses5-dev,\
libatlas-base-dev,wcslib-dev,hdf5-tools,libhdf5-dev,libhdf5-serial-dev,\
libzmq-dev,liblzo2-dev,valgrind,libssh2-1-dev,libblitz0-dev,libpqxx3-dev,\
libpq-dev,libunittest++-dev,liblog4cplus-dev,libgsl0-dev,xvfb,casacore,\
libcasacore-dev,python-pyrap,casarest,libcasarest-dev" \
--maintainer="Jose Sabater Montes\ \<jsm@iaa.es\>" \
--pkgname=lofar --pkgversion={version} --pkgrelease={pkgrelease} \
--exclude=/home --showinstall=no -y --backup=no \
make install

# Copy the result back
cp *.deb {source_dir} 

cd
sudo rm -rf LOFAR
"""

template_postinstall = """
#!/bin/bash
# Remove symbolic link
if [ -h /opt/LofIm ]; then
    rm /opt/LofIm
fi
# Create symbolic link
if [ ! -e /opt/LofIm ]; then
    ln -s /opt/LofIm-{release} /opt/LofIm
fi
"""

template_description = """
LOFAR software compilation. Release {version}.
"""

file_template = {
    "description-pak" : template_description,
    "postinstall-pak" : template_postinstall,
    "package.sh" : template_bash,
    }


if __name__ == "__main__":
    # Create files
    for fname, template in file_template.iteritems():
        with open(os.path.join(config["source_dir"], fname), "wb") as f:
            f.write(template.format(**config))
    
    # Execute files
    bash_file = os.path.join(config["source_dir"], "package.sh")
    os.chmod(bash_file, 755)
    command = ". "+bash_file
    print command
    os.system(command)