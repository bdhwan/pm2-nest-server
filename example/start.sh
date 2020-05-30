#!/bin/bash
echo "ok"
rm -rf package-lock.json
npm install --production
nest build
pm2-docker process.yml