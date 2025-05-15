#!/usr/bin/env bash
# Copyright 2017-2021 (c) all rights reserved
# by S D Rausty https://sdrausty.github.io
# installs and updates submodules from https://github.com/shlibs
#####################################################################
set -Eeuo pipefail
shopt -s nullglob globstar
. "$RDR"/scripts/bash/init/atrap.bash 137 138 139 "${0##*/} ushlibs.bash"
_IRGR_() { # initialize a remote git repository
		local USER="BuildAPKs"
		local HOSTIP="github.com"
		local PROJECT="buildAPKs"
		git init
		git remote add origin ssh://${USER}@${HOSTIP}${PROJECT}.git
}

_UFSHLIBS_() { # add and update submodules
	declare -A ARSHLIBS # declare associative array for available submodules
	ARSHLIBS=([scripts/bash/shlibs]="shlibs/shlibs.bash" [scripts/sh/shlibs]="shlibs/shlibs.sh" [opt/api/github]="BuildAPKs/buildAPKs.github" [opt/db]="BuildAPKs/db.BuildAPKs")
	_ADDMODULE_() {
		printf "\\e[1;7;38;5;96mAdding submodule ~/%s from Internet site %s address:\\e[0m\\n" "${RDR##*/}/$MLOC" "$SIAD/${ARSHLIBS[$MLOC]}" ; git submodule add "$SIAD/${ARSHLIBS[$MLOC]}" "$MLOC" || printf "Cannot add module ~/%s/scripts/%s: Continuing...\\n" "${RDR##*/}" "$MLOC"
		_SLEEPSHUF_
	}
	_UPDATEMODULE_() {
		printf "\\e[1;7;38;5;96mUpdating submodule ~/%s from Internet site %s address:\\e[0m\\n" "${RDR##*/}/$MLOC" "$SIAD/${ARSHLIBS[$MLOC]}" ; git submodule update --init --depth 1 --recursive --remote "$MLOC" || printf "Cannot update module ~/%s/scripts/%s: Continuing...\\n" "${RDR##*/}" "$MLOC"
		_SLEEPSHUF_
	}
	_SLEEPSHUF_() {
		sleep 0.$(shuf -i 24-72 -n 1) # add network latency support on fast networks
	}
	printf "\\e[1;7;38;5;98mInstalling %s prerequisite components of ~/%s/:\\e[0m\\n" "${#ARSHLIBS[@]}" "${RDR##*/}"
	for MLOC in "${!ARSHLIBS[@]}"
	do
		rm -f scripts/$MLOC/.git
		if [ -f "$RDR"/.gitmodules ]
		then
			{ grep "$MLOC" "$RDR"/.gitmodules && _UPDATEMODULE_ ; } || _ADDMODULE_
		else
			_ADDMODULE_
		fi
	done
}

SIAD="https://github.com" # define site address
[ ! -d "$RDR"/.git ] && _IRGR_ && sleep 0.$(shuf -i 24-72 -n 1)
if [[ ! -f "$RDR"/scripts/bash/shlibs/.git ]] || [[ ! -f "$RDR"/scripts/sh/shlibs/.git ]]
then
	cd "$RDR"
	git pull --ff-only || printf "\\nCannot update ~/%s: Continuing...\\n\\n" "${RDR##*/}"
	sleep 0.$(shuf -i 24-72 -n 1) # add network latency support on fast networks
	_UFSHLIBS_
fi
# ushlibs.bash EOF
