#!/bin/bash

WORKING_DIR=$(pwd)
source ${WORKING_DIR}/tools/local-config.sh

echo -e

echo 'Europe/Moscow' > /etc/timezone &&
ln -fs /usr/share/zoneinfo/`cat /etc/timezone` /etc/localtime &&
dpkg-reconfigure -f noninteractive tzdata

DATE=`date +%Y%m%d-%H%M`

FOLDER_NAME=${DATE}
ARCHIVE_NAME=bGUI_${FOLDER_NAME//-}

echo -e

echo 'Creating a project archive...'

if [ ! -w ${OUTPUT_FOLDER} ]
then
  echo '  Destination folder is not writable or does not exists : '${OUTPUT_FOLDER}
  echo 'Done.';
  exit 1100;
fi

SUBDIRS=$(find ./output -maxdepth 1 -type d -not -name output)

if [ ! -z "${SUBDIRS}" ]
then
  echo '  Destination folder is not empty. You must remove subfolders'
  echo 'Done.';
  exit 1101;
fi

echo ${SUBDIRS}

echo 'Done.';
