#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh

YUI_COMPRESSOR=${WORKING_DIR}'/tools/yuicompressor-2.4.8.jar'

echo -e
echo 'YUI compressor :'

echo '  Building pre_common.js..'
java -jar ${YUI_COMPRESSOR} --type js ${PRE_COMMON_JS} -o ${PRE_COMMON_JS}

echo '  Building common.js..'
java -jar ${YUI_COMPRESSOR} --type js  ${COMMON_JS} -o ${COMMON_JS}

echo '  Building dhtmlx.js..'
java -jar ${YUI_COMPRESSOR} --type js  ${DHTMLX_JS} -o ${DHTMLX_JS}

echo 'Done.'

echo -e