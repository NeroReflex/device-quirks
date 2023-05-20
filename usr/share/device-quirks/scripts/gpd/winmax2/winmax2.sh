#!/bin/bash
if [ $(whoami) != 'root' ]; then
  echo "You must be root to run this script."
  exit 1
fi
 
if [ -d /tmp/frzr_root ]; then
  source ${SUBVOL}/etc/device-quirks.conf
else
  source /etc/device-quirks.conf
fi

if [[ $USE_FIRMWARE_OVERRIDES == 1 ]]; then
  # Do DSDT override.
  echo "Enabling DSDT Override"
  $DQ_PATH/scriipts/override_dsdt "gpd_winmax2"
else
  echo "Firmware overrides are disabled, skipping...\n"
  echo "To enable firmware overrides, edit /etc/device-quirks/device-quirks.conf"
fi