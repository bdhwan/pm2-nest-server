#docker compose file

```
version: '3.5'
services:
  nest-proxy:
    hostname: 'nest-proxy'
    image: bdhwan/pm2-nest-server:0.0.2
    restart: always
    logging:
      driver: "json-file"
      options:
        max-size: "10MB"
        max-file: "10"
    environment:
      GIT_URL: "your_git_url_with_token"
      BRANCH: "branch_to_check_out"
      PORT:"service_port_will_use_healthcheck"
    ports:
    - "8092:8080"
```


#exposed port    
8080 80 443 3000 


#in source of root you need start.sh for init script
<p>this docker image just clone git project and call start.sh in your project root</p>

#example start.sh

```
#!/bin/bash
echo "ok"
rm -rf package-lock.json
npm install --production
nest build
pm2-docker process.yml
```





#example process.yml

```
#!/bin/bash
apps:
  - script   : dist/main.js
    name     : proxy
    exec_mode: cluster
    env:
      NODE_ENV : 'production'
    instances: 1
```



#example healthcheck response nest
```
  @Get('healthcheck')
  healthcheck(@Req() req: Request, @Res() res: Response) {
    res.status(200).json('success node-env:' + process.env.NODE_ENV);
  }
```



#example healthcheck response express
```
app.get('/healthcheck', function (req, res) {
    res.status(200).json('success-v12 node-env:' + process.env.NODE_ENV);
});

```