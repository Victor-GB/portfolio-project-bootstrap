#!/usr/bin/env bash

# Source this file to load the shortcuts into the current Bash session.
LOGRUN_PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)" || return

lg() (
    # The subshell keeps this setting local to the function.
    set -o pipefail

    if [[ $# -eq 0 ]]; then
        printf 'Usage: lg command [arguments...]\n' >&2
        return 2
    fi

    mkdir -p -- "$LOGRUN_PROJECT_ROOT/tmp" || return

    local log_file
    log_file="$(mktemp "$LOGRUN_PROJECT_ROOT/tmp/logrun-$(date +%Y%m%d-%H%M%S)-${1##*/}-XXXXXX.log")" || return

    printf 'Log: %s\n' "$log_file"
    "$@" 2>&1 | tee "$log_file"
)

o() {
    code -r "$@"
}

co() {
    touch -- "$@" || return
    o "$@"
}

sa() {
    source "$LOGRUN_PROJECT_ROOT/scripts/aliases.sh"
}

rml() {
    rm -f -- "$LOGRUN_PROJECT_ROOT"/tmp/*.log
}
