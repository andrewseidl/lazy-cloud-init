#!/bin/sh

REPOURL="https://raw.githubusercontent.com/andrewseidl/lazy-cloud-init/master/"

curl -O $REPOURL/lazy-cloud-init.sh
chmod +x lazy-cloud-init.sh
./lazy-cloud-init.sh
