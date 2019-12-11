#!/usr/bin/env bash

SHOPWARE_PROJECT=$2
SHOPWARE_FOLDER=${CODE_DIRECTORY}/${SHOPWARE_PROJECT}
URL=http://${SHOPWARE_PROJECT}.sw5.tinect.de

if [[ -f "$SHOPWARE_FOLDER/public/index.php" ]]; then
    URL=http://${SHOPWARE_PROJECT}.sw6.tinect.de
fi

checkParameter

if which xdg-open > /dev/null
then
  xdg-open ${URL}
elif which gnome-open > /dev/null
then
  gnome-open ${URL}
elif which open > /dev/null
then
  open ${URL}
fi
