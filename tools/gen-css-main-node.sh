#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh;

BRAND_FIND='dflt'
#MAIN_FILE='main.css'
MAIN_FILE=${PROJECT_PATH}'/'${TMBASE}'/_gen/'${BRAND_FIND}'/main.css'

LESS_PATH='/usr/local/share/.config/yarn/global/node_modules/less/bin/lessc'
#LESS_OPTIONS='--glob --clean-css --relative-urls'
#LESS_OPTIONS='--glob --clean-css --rewrite-urls=all'
LESS_OPTIONS='--glob --clean-css  --rewrite-urls=all'
#LESS=call node %LESS_PATH%\lessc

echo -e
echo '{{{ Start PROD css-build'
echo '  Building main.css : '${MAIN_FILE}

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
  echo '  Less : '${PROJECT_PATH}'/'${TMBASE}'/_conf/'${BRAND_FIND}'/variables.less'

  node /usr/local/share/.config/yarn/global/node_modules/less/bin/lessc \
                        ${LESS_OPTIONS} --global-var="brand-suffix=${BRAND_FIND}" \
                        ${PROJECT_PATH}'/'${TMBASE}'/_platform/core/main.less' \
                        ${MAIN_FILE}

fi



#if exist "..\%TMBASE%\_gen\%1\%MAIN_FILE%.map" del /F "..\%TMBASE%\_gen\%1\%MAIN_FILE%.map"
#if exist "..\%TMBASE%\_gen\%1\%MAIN_FILE%.gz"  del /F "..\%TMBASE%\_gen\%1\%MAIN_FILE%.gz"
#if exist "..\%TMBASE%\_gen\%1\%MAIN_FILE%"     del /F "..\%TMBASE%\_gen\%1\%MAIN_FILE%"
#if exist ..\%TMBASE%\_conf\%1\variables.less (
#    %LESS% %LESS_OPTIONS% --global-var="brand-suffix=%1" ..\%TMBASE%\_platform\core\main.less ..\%TMBASE%\_gen\%1\%MAIN_FILE%
#) else (
#    %LESS% %LESS_OPTIONS% --global-var="brand-suffix=dflt"  ..\%TMBASE%\_platform\core\main.less ..\%TMBASE%\_gen\%1\%MAIN_FILE%
#)

#if "%MAIN_FILE%" == "main.css" (
#    if exist ..\%TMBASE%\_gen\%1\%MAIN_FILE% (
#        echo deflating ..\%TMBASE%\_gen\%1\%MAIN_FILE%
#        "../exe/gzip" "..\%TMBASE%\_gen\%1\%MAIN_FILE%" -k -n -f --best
#    )
#)
#echo.

echo -e
echo 'Done. }}}'
echo -e
