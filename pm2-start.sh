cd ./api-server && pm2 start bin/start.js -i max --name "heron.wechat-api-server" --node-args="--harmony NODE_ENV=production"
echo '============   api-server pm2 started ============'
cd ..
cd ./web-server && pm2 start bin/start.js -i max --name "heron.wechat-web-server" --node-args="--harmony NODE_ENV=production"
echo '============   web-server pm2 started ============'
