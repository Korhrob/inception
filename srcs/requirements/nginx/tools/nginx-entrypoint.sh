#!/bin/sh

set -e

# Configuration
DOMAIN=${DOMAIN_NAME}
CERT_DIR=${CERTS_}
DAYS_VALID=365

# Filenames
KEY_FILE="$CERT_DIR/$DOMAIN.key"
CERT_FILE="$CERT_DIR/$DOMAIN.crt"

# Create cert directory if it doesn't exist
mkdir -p "$CERT_DIR"

# Generate the private key
openssl genrsa -out "$KEY_FILE" 2048

# Generate the certificate
openssl req -new -x509 -key "$KEY_FILE" -out "$CERT_FILE" -days "$DAYS_VALID" -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=Hive/OU=Student/CN=$DOMAIN"

sed -e "s|__HOST_NAME__|$DOMAIN_NAME|g" \
    -e "s|ssl_certificate .*;|ssl_certificate $CERT_FILE;|g" \
    -e "s|ssl_certificate_key .*;|ssl_certificate_key $KEY_FILE;|g" \
    /tmp/default.conf > /etc/nginx/conf.d/default.conf

echo "Starting NGINX..."
nginx -g "daemon off;"
