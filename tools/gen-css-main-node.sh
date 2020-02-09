#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh;

BRAND_FIND='dflt'
MAIN_FILE=${PROJECT_PATH}'/'${TMBASE}'/_gen/'${BRAND_FIND}'/main.css'
NODE_MODULES=${WORKING_DIR}'/node_modules'

LESS_PATH=${NODE_MODULES}'/less/bin/lessc'
LESS_OPTIONS='--glob --clean-css --relative-urls'

echo -e
echo '{{{ Start PROD css-build'
echo -e

if [ ! -d ${NODE_MODULES} ]
then
  echo '  Copy node_modules...'
  unzip ${PROJECT_PATH}'/tools/init/node_modules.zip' -d ${WORKING_DIR}  >/dev/null
fi

echo '  Building : '${MAIN_FILE}

if [ -f ${MAIN_FILE}'.map' ]
then
  echo '  Delete : '${MAIN_FILE}'.map'
  rm ${MAIN_FILE}'.map'
fi

if [ -f ${MAIN_FILE}'.gz' ]
then
  echo '  Delete : '${MAIN_FILE}'.gz'
  rm ${MAIN_FILE}'.gz'
fi

if [ -f ${MAIN_FILE} ]
then
  echo '  Delete : '${MAIN_FILE}
  rm ${MAIN_FILE}
fi

if [ -f ${PROJECT_PATH}'/'${TMBASE}'/_conf/'${BRAND_FIND}'/variables.less' ]
then
  cd ${PROJECT_PATH}'/tools/'
  echo '  Less : '${PROJECT_PATH}'/'${TMBASE}'/_platform/core/main.less'
  node ${LESS_PATH} ${LESS_OPTIONS} --global-var="brand-suffix=${BRAND_FIND}" ${PROJECT_PATH}'/'${TMBASE}'/_platform/core/main.less' ${MAIN_FILE}
fi

if [ -f ${MAIN_FILE} ]
then
  echo '  Deflating : '${MAIN_FILE}
  gzip ${MAIN_FILE} -c -n -f -9 > ${MAIN_FILE}.gz
fi

echo -e
echo 'Done. }}}'
