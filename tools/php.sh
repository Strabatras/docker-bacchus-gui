#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh

chmod +x tools/gen-js-messages-php.sh &&
./tools/gen-js-messages-php.sh