cd ./api-server && NODE_ENV=production pm2 start bin/start.js -i max --name "heron.wechat-api-server" --node-args="--harmony"
echo '============   api-server pm2 started ============'
cd ..
cd ./web-server && NODE_ENV=production pm2 start bin/start.js -i max --name "heron.wechat-web-server" --node-args="--harmony"
echo '============   web-server pm2 started ============'
