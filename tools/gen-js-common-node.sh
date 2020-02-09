#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh

echo -e
echo 'Building pre_common.js and common.js files:'

if [ -f PRE_COMMON_JS ]
then
  rm PRE_COMMON_JS
fi

if [ -f COMMON_JS ]
then
  rm COMMON_JS
fi

if [ -f DHTMLX_JS ]
then
  rm DHTMLX_JS
fi

echo -e
echo '  Building pre-common.js..'
node ${PROJECT_PATH}'/'${TMBASE}'/_build/r.js' -o ${PROJECT_PATH}'/'${TMBASE}'/_build/pre_common.build.js'
echo '  Building common.js..'
node ${PROJECT_PATH}'/'${TMBASE}'/_build/r.js' -o ${PROJECT_PATH}'/'${TMBASE}'/_build/common.build.js'
echo '  Building dhtmlx.js..'
node ${PROJECT_PATH}'/'${TMBASE}'/_build/r.js' -o ${PROJECT_PATH}'/'${TMBASE}'/_build/dhtmlx.build.js'
echo '  Copy dhtmlx.js..'
cp ${PROJECT_PATH}'/'${TMBASE}'/_gen/dhtmlx.js' ${PROJECT_PATH}'/'${TMBASE}'/_platform/core/dhtmlxSuite/codebase/'

echo -e
echo 'Done.'