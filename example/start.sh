#!/bin/bash
echo "ok"
rm -rf package-lock.json
npm install --production
tsc
pm2-docker process.yml