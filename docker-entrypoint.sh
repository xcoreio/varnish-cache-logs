#!/bin/sh
set -e

VARNISHD_OPTS=" \
  -f /etc/varnish/default.vcl \
  -a http=:$VARNISH_HTTP_PORT,HTTP \
  -a proxy=:$VARNISH_PROXY_PORT,PROXY \
  -p feature=+http2 \
  -s malloc,$VARNISH_SIZE \
"
VARNISHD_LOG_OPTS=""
VARNISHD="$(command -v varnishd) ${VARNISHD_OPTS}"
VARNISHD_LOG="exec $(command -v varnishlog) ${VARNISHD_LOG_OPTS}"

${VARNISHD}
eval "${VARNISHD_LOG}"