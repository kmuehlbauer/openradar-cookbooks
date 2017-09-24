#!/usr/bin/env bash
# Copyright (c) 2017, openradar developers.
# Distributed under the BSD 3-Clause license. See LICENSE for more info.

set -e

cd "$OPENRADAR_BUILD_DIR"

# print the vars
echo "TRAVIS_PULL_REQUEST " $TRAVIS_PULL_REQUEST
echo "TRAVIS_SECURE_ENV_VARS " $TRAVIS_SECURE_ENV_VARS
echo "TRAVIS_TAG " $TRAVIS_TAG ${TRAVIS_TAG:1}
echo "TRAVIS_COMMIT " $TRAVIS_COMMIT

# remove possible build residues
rm -rf doc-build
rm -rf openradar-cookbook-docs

# create doc build directory
mkdir doc-build

# create docs and upload to openradar-cookbooks repo gh-pages branch if this is not a pull request and
# secure token is available.
# else build local docs
if [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ $TRAVIS_SECURE_ENV_VARS == 'true' ]; then

    # build docs
    sphinx-build -b html doc/source doc-build

    echo "Pushing Docs"
    cd doc-build
    git config --global user.email "openradar-bot@openradarscience.org"
    git config --global user.name "openradar-bot"
    git init
    touch README
    git add README
    git commit -m "Initial commit" --allow-empty
    git branch gh-pages
    git checkout gh-pages
    touch .nojekyll
    git add --all .
    git commit -m "Version" --allow-empty
    git remote add origin https://$GH_TOKEN@github.com/openradar/openradar-cookbooks.git &> /dev/null
    git push origin gh-pages -fq &> /dev/null

else

    echo "Building Local Docs"
    sphinx-build -b html doc/source doc-build/latest
    echo "Not Pushing Docs"

fi

exit 0
