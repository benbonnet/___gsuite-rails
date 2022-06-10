#!/bin/sh
set -e

mkdir -p tmp/pids

if [ -f tmp/pids/server.pid ]; then
  echo "REMOVING PID"
  rm tmp/pids/server.pid
fi

if [ "$RUN_MIGRATIONS" ]; then
  bundle exec rails db:migrate
fi

echo '--------- Starting app // ---------'
exec bundle exec "$@"
