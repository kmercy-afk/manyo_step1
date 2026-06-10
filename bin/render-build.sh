#!/usr/bin/env bash
# bin/render-build.sh

set -e

echo "=== Installing gems ==="
bundle install

echo "=== Precompiling assets ==="
rails assets:precompile

echo "=== Running database migrations ==="
rails db:migrate

echo "=== Seeding initial data ==="
rails db:seed

echo "=== Build completed successfully ==="