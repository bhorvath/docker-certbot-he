#!/bin/sh

# Do we have everything we need?
if [[ -z "$HE_UPDATE_KEY" ]] || [[ -z "$CERTBOT_DOMAIN" ]] || [[ -z "$CERTBOT_VALIDATION" ]]; then
  echo '$HE_UPDATE_KEY, $CERTBOT_DOMAIN and $CERTBOT_VALIDATION environment variables required.'
  exit 1
fi

# Create a FQDN based on $CERTBOT_DOMAIN
HE_DOMAIN="_acme-challenge.$CERTBOT_DOMAIN"

# Update HE DNS record
echo "Updating TXT record for $HE_DOMAIN"
curl -s -X POST "https://dyn.dns.he.net/nic/update" -d "hostname=$HE_DOMAIN" -d "password=$HE_UPDATE_KEY" -d "txt=$CERTBOT_VALIDATION"

# Sleep to make sure the change has time to propagate to secondary servers
sleep 30
