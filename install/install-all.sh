#!/usr/bin/env bash
set -e
set -o Pipefail

./install-yay.sh
./setup-ntpd.sh
./install-common.sh
./make-symlinks.sh
