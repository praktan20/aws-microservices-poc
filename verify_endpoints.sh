#!/bin/bash

ALB_DNS=$1

if [ -z "$ALB_DNS" ]; then
  echo "Usage: ./verify_endpoints.sh <ALB-DNS>"
  exit 1
fi

check() {
  URL=$1
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)

  if [ "$STATUS" -ne 200 ]; then
    echo "FAILED: $URL returned $STATUS"
    exit 1
  fi
}

check http://$ALB_DNS/service1/health
check http://$ALB_DNS/service2/health

echo "All checks passed!"
exit 0
