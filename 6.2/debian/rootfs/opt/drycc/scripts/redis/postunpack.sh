#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load Redis environment variables
. /opt/drycc/scripts/redis-env.sh

# Load libraries
. /opt/drycc/scripts/libredis.sh
. /opt/drycc/scripts/libfs.sh

for dir in "$REDIS_VOLUME_DIR" "$REDIS_DATA_DIR" "$REDIS_BASE_DIR" "$REDIS_CONF_DIR"; do
    ensure_dir_exists "$dir"
done
chmod -R g+rwX /drycc "$REDIS_VOLUME_DIR" "$REDIS_BASE_DIR"

touch "${REDIS_BASE_DIR}/redis-default.conf"
cp "${REDIS_BASE_DIR}/redis-default.conf" "$REDIS_CONF_FILE"
chmod g+rw "$REDIS_CONF_FILE"
# Default Redis config
info "Setting Redis config file..."
redis_conf_set port "$REDIS_DEFAULT_PORT_NUMBER"
redis_conf_set dir "$REDIS_DATA_DIR"
redis_conf_set pidfile "$REDIS_PID_FILE"
redis_conf_set daemonize yes
