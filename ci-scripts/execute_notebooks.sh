#!/usr/bin/env bash
# Copyright (c) 2017, openradar developers.
# Distributed under the BSD 3-Clause license. See LICENSE for more info.

exit_status=0

# run tests, retrieve exit status
./testrunner.py -e -s
(( exit_status = ($? || $exit_status) ))
./testrunner.py -n -s
(( exit_status = ($? || $exit_status) ))

exit $exit_status
