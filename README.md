# docker-certbot-he

A container for creating and renewing Let's Encrypt certificates using a DNS challenge with the domain's DNS hosted on Hurricane Electric.

# Build instructions

Build the docker image locally:
```
cd docker-certbot-he
docker build -t certbot-he .
```

## Prerequisites

You must first create a TXT record in Hurricane Electric for the domain you are creating a certificate for (`example.com` in this case). The record should look as follows.

Field                        | Value
-----                        | -----
Name                         | \_acme-challenge.example.com
Text data                    | Can be set to anything for now
TTL                          | 5 minutes (300)
Enable entry for dynamic dns | true

Now set an authentication key for the TXT record by clicking on the circular arrows in the `DDNS` column. This should be noted, however it should be kept secret.

## Running the container

Most arguments can be passed to the container as if you were using `certbot` alone. See the [documentation](https://eff-certbot.readthedocs.io/en/stable/using.html).

You must set the `HE_UPDATE_KEY` environment variable to the authentication key that you previously set for the TXT record.

An example to create a certificate:
```
docker run --rm -it -e HE_UPDATE_KEY=SuperSecretKey -v "/etc/letsencrypt:/etc/letsencrypt" certbot-he certonly -d example.com -m letsencrypt@example.com
```
