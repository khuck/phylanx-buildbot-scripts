#!/bin/bash -e

steps=all
if [ $# -eq 3 ] ; then
    buildtype=$1
    step=$2
fi
echo "Component HPX, buildtype ${buildtype}, step ${step}"

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

# load common settings
if [ -z ${eigen_src_dir} ] ; then
    . ${scriptdir}/buildbot_common.sh
fi

pythonpath=`which python3`

configure_phylanx()
{
    echo "Removing old phylanx build..."
    rm -rf ${phylanx_build_dir}
    mkdir -p ${phylanx_build_dir}
    cd ${phylanx_build_dir}

    export CC=${mycc}
    export CXX=${mycxx}
    export FC=${myfc}
    export CFLAGS=${mycflags}
    export CXXFLAGS=${mycxxflags}
    #export LDFLAGS="${myldflags} ${HDF5_LDFLAGS}"
    export LDFLAGS=${myldflags}
    export blaze_DIR=${blaze_build_dir}
    export BlazeTensor_DIR=${blazetensor_build_dir}
    export HighFive_DIR=${high5_build_dir}

    set -x
    cmake \
    -DCMAKE_BUILD_TYPE=${buildtype} \
    -Dblaze_DIR=${blaze_DIR} \
    -DPHYLANX_WITH_BLAZE_TENSOR=ON \
    -DBlazeTensor_DIR=${BlazeTensor_DIR} \
    ${blaze_cmake_extras} \
    -Dpybind11_DIR=${pybind_build_dir}/share/cmake/pybind11 \
    -DHPX_DIR=${HPX_ROOT}/lib/cmake/HPX \
    -DPHYLANX_WITH_PSEUDO_DEPENDENCIES=On \
    -DPHYLANX_WITH_MALLOC=${malloc} \
    -DCMAKE_INSTALL_PREFIX=${phylanx_install_dir} \
    -DPYTHON_EXECUTABLE:FILEPATH=${pythonpath} \
    -DPHYLANX_WITH_CXX17=on \
    ${phylanx_src_dir}
    #-DPHYLANX_WITH_HIGHFIVE=ON \
    #-DHighFive_DIR=${high5_build_dir} \
    #-DLAPACK_DIR=${LAPACK_ROOT} \
    #-DBLAS_DIR=${BLAS_ROOT} \
    #-Dblaze_INCLUDE_DIR=${blaze_build_dir}/include \
}

build_phylanx()
{
    cd ${phylanx_build_dir}
    make ${makej}
    #make install
}

test_phylanx()
{
    cd ${phylanx_build_dir}
#    set +e
    make ${makej} -k tests 
#    rc=$?
#    if [ $rc -ne 0 ] ; then
#        make test
#    fi
}

if [ ${step} == "all" ] || [ ${step} == "configure" ] ; then
    configure_phylanx
fi
if [ ${step} == "all" ] || [ ${step} == "compile" ] ; then
    build_phylanx
fi
if [ ${step} == "all" ] || [ ${step} == "test" ] ; then
    test_phylanx
fi
