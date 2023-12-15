# !/bin/bash

apt-get update -y && apt-get install curl -y
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

UUID=$(cat /proc/sys/kernel/random/uuid)
echo "{
  \"inbounds\": [
    {
      \"port\": 16832, // 服务器端口
      \"protocol\": \"vmess\",   
      \"settings\": {
        \"clients\": [
          {
            \"id\": \"uuid\",  // 用户 ID，客户端与服务器必须相同
            \"alterId\": 0
          }
        ]
      }
    }
  ],
  \"outbounds\": [
    {
      \"protocol\": \"freedom\",  
      \"settings\": {}
    }
  ]
}" > /usr/local/etc/v2ray/config.json
sed -i "s/uuid/$UUID/g" /usr/local/etc/v2ray/config.json

systemctl restart v2ray

wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh