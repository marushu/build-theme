#!/usr/bin/env bash

echo -n "What is your theme name? : "
read THEME_NAME

echo -n "What is your theme slug? : "
read THEME_SLUG

if [ ! -d ../dist ]; then
  mkdir ../dist
fi

VCCW_HOST_NAME=$(grep "hostname:" ../site.yml | sed -e s/hostname://g | tr -d '\"\ ' | sed -n 1p)

cd ../wordpress  && wp scaffold _s "${THEME_SLUG}" --activate --theme_name="${THEME_NAME}" --sassify

cd wp-content/themes/${THEME_SLUG}

git clone git@github.com:marushu/package.git

cp package/package.json .

grep "\"serve"\" ./package.json | sed -i '' -e "s/vccw.dev/${VCCW_HOST_NAME}/g" ./package.json

rm -rf package/

open http://"${VCCW_HOST_NAME}"/wp-admin
open http://"${VCCW_HOST_NAME}"

cat ../../../../build-theme/mixin.txt | awk '{print $0}' >> ./sass/style.scss

npm install

npm run watch:all
