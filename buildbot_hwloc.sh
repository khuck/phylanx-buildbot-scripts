
#!/bin/bash
set -x

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

. ${scriptdir}/buildbot_common.sh

workdir=/dev/shm/src
if [ "${host}" == "centaur" ] || [ "${host}" == "delphi" ] || [ "${host}" == "grover" ] || [ "${host}" == "talapas" ] ; then
    workdir=${sourcedir}/hwloc
fi

mkdir -p ${workdir}
cd ${workdir}

if [ ! -d hwloc-1.11.5 ] ; then
    if [ ! -f hwloc-1.11.5.tar.bz2 ] ; then
        wget https://www.open-mpi.org/software/hwloc/v1.11/downloads/hwloc-1.11.5.tar.bz2
    fi
    tar xvjf hwloc-1.11.5.tar.bz2
fi

mkdir -p hwloc-1.11.5/build
cd hwloc-1.11.5/build
../configure --prefix=${hwloc_path}
make ${makej}
make install
cd ..
