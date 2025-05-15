#!/usr/bin/env bash
# Copyright 2019-2021 (c) all rights reserved
# by SDRausty https://sdrausty.github.io
#####################################################################
set -Eeuo pipefail
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
[ "$PWD" = "$PREFIX" ] || [ "$PWD" = "$HOME" ] || [ "$PWD" = "$RDR" ] && printf "\\e[?25h\\e[1;7;38;5;0mSignal 224 generated in %s;  Command '${0##*/}' cannot be run in directory %s; %s exiting...\\e[0m\\n" "$PWD" "$PWD" "${0##*/} build.in.dir.bash" && exit 224
. "$RDR"/scripts/bash/init/atrap.bash 201 211 221 "${0##*/} build.in.dir.bash" wake.start
export JDR="$PWD"
export DAY="$(date +%Y%m%d)"
export JID="in.dir.${JDR##*/}"
export NUM="$(date +%s)"
export OAUT="$(cat "$RDR/.conf/GAUTH" | awk 'NR==1')" # load login:token key from .conf/GAUTH file, see the GAUTH file for more information to enable OAUTH authentication
. "$RDR"/scripts/bash/init/ushlibs.bash
. "$RDR"/scripts/bash/shlibs/buildAPKs/bnchn.bash bch.st
. "$RDR"/scripts/bash/shlibs/buildAPKs/fandm.bash
_ANDB_
. "$RDR"/scripts/bash/shlibs/buildAPKs/bnchn.bash bch.gt
# build.in.dir.bash EOF
