#!/usr/bin/env bash

if [ -z "${1}" ]; then
  echo -n "What is your theme name? : "
  read THEME_NAME
else
  THEME_NAME=${1}
fi

# Check argument 1(theme slug)
if [ -z "${2}" ]; then
  echo -n "What is your theme slug? : "
  read THEME_SLUG
else
  THEME_SLUG=${2}
fi

if [ ! -d ../dist ]; then
  mkdir ../dist
fi

VCCW_HOST_NAME=$(grep "hostname:" ../site.yml | sed -e s/hostname://g | tr -d '\"\ ' | sed -n 1p)

VCCW_SITE_URL=$(grep "wp_siteurl:" ../site.yml | sed -e "s/wp_siteurl://" | sed -e "s/\# Path to the WP_SITEURL like \"wp\"//g" | tr -d "\'\ ")

[ -z "${VCCW_SITE_URL}" ] && VCCW_SITE_URL='' || VCCW_SITE_URL="/${VCCW_SITE_URL}"

cd ../wordpress  && wp scaffold _s "${THEME_SLUG}" --activate --theme_name="${THEME_NAME}" --sassify

cd wp-content/themes/${THEME_SLUG}

git clone git@github.com:marushu/package.git

cp package/package.json .

grep "\"serve"\" ./package.json | sed -i '' -e "s/vccw.test/${VCCW_HOST_NAME}/g" ./package.json

rm -rf package/

open http://"${VCCW_HOST_NAME}""${VCCW_SITE_URL}"/wp-admin
open http://"${VCCW_HOST_NAME}"

cat ../../../../build-theme/mixin.txt | awk '{print $0}' >> ./sass/style.scss

npm install

npm run watch:all
