#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh
echo -e

echo 'Compressing :'
echo '  ' ${PRE_COMMON_JS}
gzip ${PRE_COMMON_JS} -c -n -f -9 > ${PRE_COMMON_JS}.gz
echo '  ' ${COMMON_JS}
gzip ${COMMON_JS} -c -n -f -9 > ${COMMON_JS}.gz
echo '  ' ${DHTMLX_JS}
gzip ${DHTMLX_JS} -c -n -f -9 > ${DHTMLX_JS}.gz

echo 'Compressing finished!'
