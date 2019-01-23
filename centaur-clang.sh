#gcc_dir=/usr/local/packages/llvm/5.0.2
#llvm_dir=/usr/local/packages/llvm/5.0.2
export SPACK_ROOT=$HOME/src/hpx/spack
. $SPACK_ROOT/share/spack/setup-env.sh
spack load llvm
cmake_dir=/usr/local/packages/cmake/3.9.2-ppc64le
python3_dir=/usr/local/packages/python3/3.6.3
mpi_dir=/usr/local/packages/openmpi/3.1.1-clang5.0
PATH=${cmake_dir}/bin:${python3_dir}/bin:${mpi_dir}/bin:$PATH
LD_LIBRARY_PATH=${python3_dir}/lib:${mpi_dir}/lib:$LD_LIBRARY_PATH
export PYTHONDOCS=${python3_dir}/html

# module load python/3.3.4

# special flags for some library builds
export mycflags="-fPIC"
export mycxxflags="-fPIC"
export myldflags="-fPIC"
export mycc=clang
export mycxx=clang++

export host=centaur
arch=`arch`
uname=`uname`

if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export basedir=$( dirname "${scriptdir}" )
export myarch=${host}-${arch}-${uname}-${mycc}
export buildtype=Release
export malloc=tcmalloc
export contrib=${basedir}/build-${myarch}/contrib
export malloc_path=/usr/local/packages/gperftools/2.5
export activeharmony_path=/usr/local/packages/activeharmony/4.6.0-${arch}
export otf2_path=/usr/local/packages/otf2/2.0-ppc64le
export papi_path=/usr/local/packages/papi/5.5.1
export boost_path=${basedir}/buildbot/build-${myarch}/boost-1.65.1
export BOOST_DIR=${boost_path}
export BOOST_ROOT=${boost_path}
export LAPACK_DIR=/usr/local/packages/lapack/3.7.1-gcc
#export BLAS_ROOT=/usr/local/packages/ATLAS/3.10.3
export BLAS_DIR=/usr/local/packages/lapack/3.7.1-gcc
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/packages/lapack/3.7.1-gcc/lib64/pkgconfig
export LAPACK_ROOT=${LAPACK_DIR}
export BLAS_ROOT=${BLAS_DIR}
#export blaze_cmake_extras="-DBLAS_LIBRARIES=/usr/local/packages/ATLAS/3.10.3/lib/libcblas.a -DLAPACK_LIBRARIES=/usr/local/packages/ATLAS/3.10.3/lib/liblapack.a"
export blaze_cmake_extras="-DBLAS_LIBRARIES=${BLAS_DIR}/lib64/libblas.so -DLAPACK_LIBRARIES=${LAPACK_DIR}/lib64/liblapack.so"
export cmake_extras=" -DHWLOC_ROOT=/usr/local/packages/hwloc/1.8 -DHPX_WITH_RDTSCP=OFF -DHPX_WITH_DEPRECATION_WARNINGS=Off "

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
