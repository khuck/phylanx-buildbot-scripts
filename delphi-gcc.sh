export SPACK_ROOT=/usr/local/packages/phylanx-dependencies-spack
source ${SPACK_ROOT}/share/spack/setup-env.sh

module load gcc-7.3.0-gcc-4.9.3-wc3hmpi
# With exceptions
#module load openmpi-3.1.4-gcc-7.3.0-nuywq34
# Without exceptions
module load openmpi-3.1.4-gcc-7.3.0-dkwj752
module load python-3.7.0-gcc-7.3.0-mkfg5va
module load cmake-3.16.1-gcc-7.3.0-leo4lqw
module list

# special flags for some library builds
export mycflags="-fPIC"
export mycxxflags="-fPIC"
export myldflags="-fPIC -Wl,--allow-multiple-definition"
export mycc=gcc
export mycxx=g++
export myfc=gfortran

export host=delphi
arch=`arch`
uname=`uname`

if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export basedir=$( dirname "${scriptdir}" )
export myarch=${host}-${arch}-${uname}-gcc
export buildtype=Release
export malloc=tcmalloc
export malloc_path=`spack location -i gperftools`
export activeharmony_path=`spack location -i activeharmony`
export otf2_path=`spack location -i otf2`
export papi_path=`spack location -i papi`
export boost_path=`spack location -i boost`
export BOOST_DIR=${boost_path}
export BOOST_ROOT=${boost_path}
export LAPACK_DIR=`spack location -i openblas`
export BLAS_DIR=`spack location -i openblas`
export LAPACK_ROOT=${LAPACK_DIR}
export BLAS_ROOT=${BLAS_DIR}
export HDF5_ROOT=`spack location -i hdf5`
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:${LAPACK_ROOT}/lib/pkgconfig
#export HDF5_LDFLAGS="-L/usr/local/packages/szip/2.1/gcc-4.9/lib -ldl -lz -lsz"

export MPICC=mpicc
export MPICXX=mpicxx

echo ""
echo "NB: "
echo "basedir is set to ${basedir}."
echo "  All paths are relative to that base."
echo "myarch is set to ${myarch}."
echo "  Build output will be in ${basedir}/build-${myarch}."
echo ""
echo "CC = `which $mycc`"
echo "CXX = `which $mycxx`"
echo "MPICC = `which mpicc`"
echo "MPICXX = `which mpicxx`"
