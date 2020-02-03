#!/bin/bash

case "$BUILD" in
     messages)
          chmod +x tools/gen-js-messages-php.sh &&
          ./tools/gen-js-messages-php.sh
          ;;
     archive)
          chmod +x tools/gen-deploy-archive-gzip.sh &&
          ./tools/gen-deploy-archive-gzip.sh.sh
          ;;
     *)
          echo -e
          echo 'Usage: docker-compose run -e BUILD=(messages|archive) php'
          ;;
esac
echo -e
