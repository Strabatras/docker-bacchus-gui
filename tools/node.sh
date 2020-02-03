#!/bin/bash

case "$BUILD" in
     css)
          chmod +x tools/gen-css-main-node.sh &&
          ./tools/gen-css-main-node.sh
          ;;
     js)
          chmod +x tools/gen-js-common-node.sh &&
          ./tools/gen-js-common-node.sh
          ;;
     gzip)
          chmod +x tools/gen-js-common-gzip.sh &&
          ./tools/gen-js-common-gzip.sh
          ;;
     *)
          echo -e
          echo 'Usage: docker-compose run -e BUILD=(css|js|gzip) nodejs'
          ;;
esac
echo -e
