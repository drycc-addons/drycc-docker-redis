#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load Redis environment variables
. /opt/drycc/scripts/redis-env.sh

# Load libraries
. /opt/drycc/scripts/libos.sh
. /opt/drycc/scripts/libfs.sh
. /opt/drycc/scripts/libredis.sh

# Ensure Redis environment variables settings are valid
redis_validate
# Ensure Redis daemon user exists when running as root
am_i_root && ensure_user_exists "$REDIS_DAEMON_USER" --group "$REDIS_DAEMON_GROUP"
# Ensure Redis is initialized
redis_initialize
