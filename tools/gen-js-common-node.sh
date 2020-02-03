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

#set PRE_COMMON_JS=..\%TMBASE%\_gen\pre_common.js
#set COMMON_JS=..\%TMBASE%\_gen\common.js
#set DHTMLX_JS=..\%TMBASE%\_gen\dhtmlx.js
#
#if exist "%PRE_COMMON_JS%"              del /F %PRE_COMMON_JS%
#if exist "%COMMON_JS%"                  del /F %COMMON_JS%
#if exist "%DHTMLX_JS%"                  del /F %DHTMLX_JS%
#if exist "%DHTMLX_JS_FOR_SAMPLE%"       del /F %DHTMLX_JS_FOR_SAMPLE%
#echo Building pre-common.js..
#node  ..\%TMBASE%\_build\r.js -o ..\%TMBASE%\_build\pre_common.build.js
#echo Building common.js..
#node  ..\%TMBASE%\_build\r.js -o ..\%TMBASE%\_build\common.build.js
#echo Building dhtmlx.js..
#node  ..\%TMBASE%\_build\r.js -o ..\%TMBASE%\_build\dhtmlx.build.js
#copy ..\%TMBASE%\_gen\dhtmlx.js ..\%TMBASE%\_platform\core\dhtmlxSuite\codebase\
#echo Done.
#
#if "%YUI_COMPRESSOR%" == "" goto JSkipMinification
#rem  java -jar %YUI_COMPRESSOR% --type css "%all_css%" -o "%all_css%"
#  java -jar %YUI_COMPRESSOR% --type js  "%PRE_COMMON_JS%" -o "%PRE_COMMON_JS%"
#  java -jar %YUI_COMPRESSOR% --type js  "%COMMON_JS%" -o "%COMMON_JS%"
#  java -jar %YUI_COMPRESSOR% --type js  "%DHTMLX_JS%" -o "%DHTMLX_JS%"
#
#:JSkipMinification
#
#rem "../exe/7z" a %PRE_COMMON_JS%.gz %PRE_COMMON_JS%
#rem "../exe/7z" a %COMMON_JS%.gz %COMMON_JS%
#rem "../exe/7z" a %DHTMLX_JS%.gz %DHTMLX_JS%
#"../exe/gzip" %PRE_COMMON_JS% -k -n -f --best
#"../exe/gzip" %COMMON_JS% -k -n -f --best
#"../exe/gzip" %DHTMLX_JS% -k -n -f --best