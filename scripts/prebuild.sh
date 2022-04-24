#!/bin/bash
echo "===== pre-build command ===="
DEBIAN_FLAVOR=$(cat /etc/os-release | grep "VERSION_CODENAME" | sed "s/VERSION_CODENAME=//")

update_platform () {
  platform=$1
  version=$2
  echo -n "Updating ${platform} to ${version} for ${DEBIAN_FLAVOR} ..."
  cd /tmp
  curl -s -O https://oryx-cdn.microsoft.io/${platform}/${platform}-${DEBIAN_FLAVOR}-${version}.tar.gz
  mkdir -p /tmp/oryx/platforms/${platform}/${version}
  tar -xzf ./${platform}-${DEBIAN_FLAVOR}-${version}.tar.gz -C /tmp/oryx/platforms/${platform}/${version}
  echo " Done."
  cd - >/dev/null
}

update_platforms () {
  PLATFORMS_PATH=$1
  platforms=($(ls ${PLATFORMS_PATH}* | sed -e "s/${PLATFORMS_PATH//\//\\/}//" | tr -d ":"))
  for ((i=0; i<${#platforms[@]}; i+=2)); do
    update_platform "${platforms[i]}" "${platforms[i+1]}"
  done;

}

update_platforms "/tmp/oryx/platforms/"

echo "===== pre-build command ===="
