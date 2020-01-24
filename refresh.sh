#!/bin/bash -e

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

if [[ "${scriptdir}" != *tools/buildbot ]] ; then
    echo "This script should only be run from the tools/buildbot directory."
    kill -INT $$
fi

# First, update the Phylanx source - assume we are in tools/buildbot
cd ${scriptdir}/../..
cwd=`pwd`

${scriptdir}/get_all_source.sh ${cwd}
