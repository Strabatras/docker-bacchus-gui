#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh

echo -e
echo 'Building language-depended messages js-files and macroses for all brandings:'

if [ ! -d ${PROJECT_PATH}'/'${TMBASE}'/_gen/app' ]
then
  echo '  Create directory : '${PROJECT_PATH}'/'${TMBASE}'/_gen/'
  mkdir -p ${PROJECT_PATH}'/'${TMBASE}'/_gen/'
fi

export TMBASE=${TMBASE}
export PROJECT_PATH=${PROJECT_PATH}

php -f tools/gen-js-messages.php all

echo -e
echo '  Starting deflate messages.js:'

find ${PROJECT_PATH}'/'${TMBASE}'/_gen/app/' -name "messages*.js" -exec gzip -k -n -f -v --best {} \;

echo '  Deflating finished!'

echo -e
echo 'Building messages and macroses finished!'
echo -e