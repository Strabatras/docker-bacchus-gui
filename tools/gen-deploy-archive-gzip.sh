#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh

echo -e

echo 'Europe/Moscow' > /etc/timezone &&
ln -fs /usr/share/zoneinfo/`cat /etc/timezone` /etc/localtime &&
dpkg-reconfigure -f noninteractive tzdata

DATE=`date +%Y%m%d-%H%M`

FOLDER_NAME=${DATE}
ARCHIVE_NAME='bGUI_'${FOLDER_NAME//-}'.tar.gz'

echo -e

echo 'Creating a project archive...'

if [ ! -w ${OUTPUT_FOLDER} ]
then
  echo '  Destination folder is not writable or does not exists : '${OUTPUT_FOLDER}
  echo 'Done.';
  exit 1100;
fi

SUBDIRS=$(find ${OUTPUT_FOLDER} -maxdepth 1 -type d -not -name output)

if [ ! -z "${SUBDIRS}" ]
then
  echo '  Destination folder is not empty. You must remove subfolders...'
  echo 'Done.';
  exit 1101;
fi

echo '  Create folder '\'${FOLDER_NAME}\'
mkdir ${OUTPUT_FOLDER}'/'${FOLDER_NAME}

echo '  Create latest_deploy.txt file...'
echo 'FNAME="depls/'${ARCHIVE_NAME}'" #' > ${OUTPUT_FOLDER}'/'${FOLDER_NAME}'/latest_deploy.txt'

echo '  Create latest_deploy.cmd.txt file...'
echo 'set FNAME='${ARCHIVE_NAME} > ${OUTPUT_FOLDER}'/'${FOLDER_NAME}'/latest_deploy.cmd.txt'

echo '  Create '${ARCHIVE_NAME}' archive...'

cd ${PROJECT_PATH} &&
tar -czf ${OUTPUT_FOLDER}'/'${FOLDER_NAME}'/'${ARCHIVE_NAME} \
                                                ${TMBASE}'/' \
                                             'dependencies/' \
                                                   'config/'

echo -e
echo 'Done.';
