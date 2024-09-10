#!/usr/bin/env bash
set -euo pipefail

echo "Filling site templates with environment veriables."

for file in /templates/*.template; do
    [[ -e "$file" ]] || continue

    file_name=$(basename "$file")
    new_name="/etc/nginx/conf.d/${file_name%.template}.conf"
    echo "Formatting ${file} -> ${new_name}"
    envsubst "$(printf '${%s} ' $(env | cut -d'=' -f1))" < $file > $new_name
done

echo "Starting nginx..."
exec nginx -g "daemon off;"
