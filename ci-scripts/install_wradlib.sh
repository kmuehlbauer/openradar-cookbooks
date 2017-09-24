#!/usr/bin/env bash
# Copyright (c) 2017, openradar developers.
# Distributed under the BSD 3-Clause license. See LICENSE for more info.

# clone and install wradlib
git clone --depth 1 https://github.com/wradlib/wradlib.git
cd wradlib
python setup.py install