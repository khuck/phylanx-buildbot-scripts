export mycc=gcc
export mycxx=g++
export myfc=gfortran

export host=taudev
arch=`arch`
uname=`uname`

if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export basedir=$( dirname "${scriptdir}" )
export myarch=${host}-${arch}-${uname}-gcc
export buildtype=Release
export malloc=tcmalloc
export malloc_path=/usr
export activeharmony_path=$HOME/install/activeharmony/4.6
export otf2_path=$HOME/install/otf2/2.1
export papi_path=
export boost_path=/usr
export BOOST_DIR=${boost_path}
export BOOST_ROOT=${boost_path}
export LAPACK_ROOT=/usr
export BLAS_ROOT=/usr
export LAPACK_ROOT=${LAPACK_DIR}
export BLAS_ROOT=${BLAS_DIR}
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:${LAPACK_ROOT}/lib64/pkgconfig
export hwloc_path=/usr

echo ""
echo "NB: "
echo "basedir is set to ${basedir}."
echo "  All paths are relative to that base."
echo "myarch is set to ${myarch}."
echo "  Build output will be in ${basedir}/build-${myarch}."
echo ""
