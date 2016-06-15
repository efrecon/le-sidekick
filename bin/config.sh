#!/usr/bin/env bash

#BASEDIR=/letsencrypt
if [ -n "${EMAIL:-}" ]; then
    CONTACT_EMAIL=$EMAIL
fi

if [ -z ${STAGING+-} ]; then
  CA="https://acme-v01.api.letsencrypt.org/directory"
else
  CA="https://acme-staging.api.letsencrypt.org/directory"
fi

if [ -z "${DOMAINS:-}" ]; then
    DOMAINS_TXT=/letsencrypt/config/domains.txt
else
    DOMAINS_TXT=$DOMAINS
fi

if [ -z "${ACCOUNTS:-}" ]; then
    ACCOUNTDIR=$(dirname "${DOMAINS_TXT}")/accounts
else
    ACCOUNTDIR=$ACCOUNTS
fi

if [ -z "${WELLKNOWN:-}" ]; then
    WELLKNOWN=/letsencrypt/wellknown
fi
