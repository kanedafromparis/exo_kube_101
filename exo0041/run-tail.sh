#!/usr/bin/env bash
#
# https://dev.to/thiht/shell-scripts-matter
#
set -euo pipefail
IFS=$'\n\t'

#/ Usage: ./run-tail.sh
#/ Description: run fortune in a loop to /opt/exchange/fortune
#/ Examples: ./run-tail.sh
#/ Options:
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $*" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $*" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $*" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $*" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

cleanup() {
    # Remove temporary files
    # Restart services
    # ...
    echo "";
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    trap cleanup EXIT
    echo "wait 15";
    sleep 15;
    # Script goes here
    COUNTER=0
    
    while [  true ]; do
             tail -f /opt/exchange/fortune ;
    done
    
fi ;


