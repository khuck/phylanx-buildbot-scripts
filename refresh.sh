#!/bin/bash -e

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

if [[ "${scriptdir}" != *phylanx/tools/buildbot ]] ; then
    echo "This script should only be run from the phylanx/tools/buildbot directory."
    kill -INT $$
fi

# First, update the Phylanx source - assume we are in phylanx/tools/buildbot
cd ${scriptdir}/../../..
cwd=`pwd`

${scriptdir}/get_all_source.sh ${cwd}
