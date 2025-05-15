#!/usr/bin/env bash
# Copyright 2017-2021 (c) all rights reserved
# by S D Rausty https://sdrausty.github.io
#####################################################################
set -Eeuo pipefail
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
. "$RDR/scripts/bash/init/atrap.bash" 67 68 69 "${0##*/} build.native.bash"
export JAD=github.com/BuildAPKs/buildAPKs.native
export JID=native2	# job id/name
[[ -f "$RDR"/.conf/DOSO ]] && [[ $(head -1 "$RDR"/.conf/DOSO) -eq 1 ]] && sed -i '1c\0' "$RDR"/.conf/DOSO
. "$HOME/buildAPKs/scripts/bash/init/init.bash" "$@"
# build.native.bash EOF
