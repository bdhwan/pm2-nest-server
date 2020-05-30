
#!/bin/bash
docker build  --no-cache --tag bdhwan/pm2-nest-server:0.0.2 .
docker push bdhwan/pm2-nest-server:0.0.2
