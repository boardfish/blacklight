#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /blacklight/tmp/pids/server.pid

bundle check || bundle install
bundle binstubs rspec-core rails

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
