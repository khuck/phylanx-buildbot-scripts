#!/bin/bash -e

set -x

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

# First, update the Phylanx source
cd ${scriptdir}/../..
cwd=`pwd`
set -x

git fetch
git fetch --tags --force
git checkout master
git pull

# Now, update the buildbot scripts
cd tools/buildbot
git fetch
git fetch --tags --force
git checkout master
git pull

# Next, update the HPX source
cd src/hpx
git fetch
git fetch --tags --force
git checkout master
git pull
git checkout stable
# Also update the apex source
if [ ! -d apex ] ; then
    git clone git@github.com:khuck/xpress-apex apex
fi
cd apex
git fetch
git fetch --tags --force
git checkout develop
git pull
cd ${cwd}/tools/buildbot

