FROM certbot/certbot:v1.30.0
RUN apk update && \
  apk add --no-cache curl && \
  rm -rf /var/lib/cache/apk/*
COPY update-he.sh /usr/libexec/
ENTRYPOINT ["certbot", "--preferred-challenges", "dns", "--manual", "--manual-auth-hook", "/usr/libexec/update-he.sh"]
