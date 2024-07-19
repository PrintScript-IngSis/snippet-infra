#!/bin/bash

# Paths to the certificate files
CERT_FILE="/etc/nginx/ssl/live/${DOMAIN_NAME}/fullchain.pem"
KEY_FILE="/etc/nginx/ssl/live/${DOMAIN_NAME}/privkey.pem"


SECURED_CONF="/etc/nginx/conf.d/server.conf.template"
TARGET_CONF="/etc/nginx/conf.d/server.conf"

# Check if both certificate files exist
if [[ -f "$CERT_FILE" && -f "$KEY_FILE" ]]; then
  echo "SSL certificates found. Using secured NGINX configuration."
  envsubst '$${DOMAIN_NAME}' < "$SECURED_CONF" > "$TARGET_CONF"
else
  echo "SSL certificates not found"
  exit 1
fi

# Start NGINX
nginx -g 'daemon off;'