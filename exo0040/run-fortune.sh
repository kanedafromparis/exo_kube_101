#!/usr/bin/env bash
#
# https://dev.to/thiht/shell-scripts-matter
#
set -euo pipefail
IFS=$'\n\t'

#/ Usage: ./run-fortune.sh
#/ Description: run fortune in a loop to /opt/exchange/fortune
#/ Examples: ./run-fortune.sh
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
    echo "" > /opt/exchange/fortune
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    trap cleanup EXIT
    # Script goes here
    COUNTER=0;
    
    while [  $COUNTER -lt 100 ]; do
             echo " local container "
             if [ "$VERBOSE" == "1" ]; then
              fortune | tee -a /opt/exchange/fortune ;
              echo "---" | tee -a /opt/exchange/fortune ;
            else
              fortune >> /opt/exchange/fortune;
              echo "---" >> /opt/exchange/fortune;
            fi ;
            sleep 2;
    done;
    
fi ;



