#! /bin/sh
# ============================================================================ #
# NAME:
#   install.sh
#
# DESCRIPTION:
#   Install Minecraft server.
# 
# ENVIRONMENT:
#   VERSION: The version to be downloaded, this will default to 'latest'.
# ============================================================================ #

main() {
    configure
    curl -o ${INSTALL_DIRECTORY}/server.jar "$(server_download_url)"
}

configure() {
    VERSION_MANIFEST_URL='https://launchermeta.mojang.com'
    VERSION_MANIFEST_URL="${VERSION_MANIFEST_URL}/mc/game"
    VERSION_MANIFEST_URL="${VERSION_MANIFEST_URL}/version_manifest.json"
    VERSION_MANIFEST_JSON=$(curl -L "${VERSION_MANIFEST_URL}")
    test -n "${VERSION}" \
        || VERSION=$(echo "${VERSION_MANIFEST_JSON}" | jq -r ".latest.release")
}

server_download_url() {
    package_manifest_url=$( \
        curl "${VERSION_MANIFEST_URL}" \
            | jq -r ".versions[] | select(.id == \"${VERSION}\") | .url" \
    )
    curl "${package_manifest_url}" | jq -r '.downloads.server.url'
}

main ${@}
