#!/usr/bin/env bash

set -e

. $HOME/.asdf/asdf.sh

# Backup IFS
_IFS="${IFS}"

# Create apps list
IFS=","
read -a asdf_apps <<< "${1}"

# Prepare IFS to split app name and app version
IFS=":"

for asdf_app in "${asdf_apps[@]}";
do
    read -a app <<< "${asdf_app}"
    asdf plugin-add "${app[0]}"
    asdf install "${app[0]}" "${app[1]}"
    asdf global "${app[0]}" "${app[1]}"
done

IFS="${_IFS}"
