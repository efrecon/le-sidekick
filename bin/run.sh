#!/usr/bin/env bash

interrupt() {
  echo
  echo "Caught ^C, exiting."
  exit 1
}

if [ -z "${PERIOD:-}" ]; then
    PERIOD=86400
fi

if [ -z "${CERTSDIR:-}" ]; then
    CERTSDIR=/letsencrypt/certs
fi

trap interrupt SIGINT

while true; do
    if [ -n "${DOMAIN:-}" ]; then
        letsencrypt.sh --cron --out $CERTSDIR --challenge http-01 --domain $DOMAIN --config /letsencrypt/bin/config.sh
        letsencrypt.sh --cleanup --out $CERTSDIR --config /letsencrypt/bin/config.sh
        sleep $PERIOD
    elif [ -n "${DOMAINS:-}" -a -f "$DOMAINS" ]; then
        letsencrypt.sh --cron --out $CERTSDIR --challenge http-01 --config /letsencrypt/bin/config.sh
        letsencrypt.sh --cleanup --out $CERTSDIR --config /letsencrypt/bin/config.sh
        inotifywait --timeout $PERIOD $DOMAINS
        sleep 60
    else
        sleep 60
    fi
done
