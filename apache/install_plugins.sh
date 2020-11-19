#! /bin/bash

MATOMO_CORE_VERSION="$1"
LICENSE_KEY="$2"

PLUGINS_TO_DOWNLOAD="HeatmapSessionRecording"

for PLUGIN_NAME in $PLUGINS_TO_DOWNLOAD
do
  echo "Downloading plugin $PLUGIN_NAME..."

  if curl -f -sS --data "access_token=$LICENSE_KEY" https://plugins.matomo.org/api/2.0/plugins/$PLUGIN_NAME/download/latest?matomo=$MATOMO_CORE_VERSION > plugins-$PLUGIN_NAME.zip; then
    echo "OK ($PLUGIN_NAME)"
  else
    echo -e "Please check your Matomo Marketplace license key is correct, and try again." >&2
    exit 1
  fi;
done;

echo -e "Extract all packages in the /usr/src/ directory..."

for PLUGIN_NAME in $PLUGINS_TO_DOWNLOAD
do
  unzip -q -o plugins-$PLUGIN_NAME -d /usr/src/matomo/plugins/
done;
