# special flags for some library builds
export mycflags="-fPIC"
export mycxxflags="-fPIC"
export myldflags="-fPIC"
export mycc=clang
export mycxx=clang++

export host=osx
arch=`arch`
uname=`uname`

if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export basedir=$( dirname "${scriptdir}" )
export myarch=${host}-${arch}-${uname}-${mycc}
export buildtype=Release
export malloc=tcmalloc
export malloc_path=/opt/local
export activeharmony_path=$HOME/install/activeharmony/4.6
export otf2_path=$HOME/install/otf2/2.1
export papi_path=""
export boost_path=/opt/local
export BOOST_DIR=${boost_path}
export BOOST_ROOT=${boost_path}
export LAPACK_DIR=/opt/local
#export BLAS_ROOT=/usr/local/packages/ATLAS/3.10.3
export BLAS_DIR=/opt/local
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/local/lib/pkgconfig
export LAPACK_ROOT=${LAPACK_DIR}
export BLAS_ROOT=${BLAS_DIR}
export hwloc_path=/opt/local
# export blaze_cmake_extras="-DBLAS_LIBRARIES=${BLAS_DIR}/lib64/libblas.so -DLAPACK_LIBRARIES=${LAPACK_DIR}/lib64/liblapack.so"
export cmake_extras=" -DHPX_WITH_RDTSCP=OFF -DHPX_WITH_DEPRECATION_WARNINGS=Off "

echo ""
echo "NB: "
echo "basedir is set to ${basedir}."
echo "  All paths are relative to that base."
echo "myarch is set to ${myarch}."
echo "  Build output will be in ${basedir}/build-${myarch}."
echo ""
