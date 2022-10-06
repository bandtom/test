# Windows VPS节点搭建教程，图形化界面只需点点鼠标即可创建节点，脱离命令行指令，小白首选

## 前言

关于节点搭建我已经出过很多教程了，都是使用`linux`在命令行操作，这也是大多数人的选择，所以参考资料也比较多，很多新手朋友刚接触linux这种纯命令行的系统是比较难上手，也有一些朋友知道有`windows`系统的VPS，比起linux纯命令行操作，图形化操作对我们普通用户要友好太多了，点点鼠标就能创建节点，就和你平时上网一样简单，但是关于windows搭建节点的资料网上太少了，有的朋友开好windwos系统的VPS之后发现根本没有教程可供参考，所以本期教大家使用windows系统来搭建节点

本期讲解三种vmess搭建节点的组合：

- vmess+tcp
- vmess+tcp+tls（自签证书）
- vmess+ws+tls+web（CA证书）

搭建的原理都在系列教程讲解过了，不管是windows还是linux，原理都是相通的，所以本教程只注重操作步骤，想要了解原理请看我录制的[系列教程](https://bulianglin.com/g/aHR0cHM6Ly95b3V0dWJlLmNvbS9wbGF5bGlzdD9saXN0PVBMNVRiYnRleFQ4VDNkXzdVWDJhU0Zob01Zay1jbDRrZjQ)。

## 相关链接
v2ray内核：[https://github.com/v2fly/v2ray-core/releases/latest](https://github.com/v2fly/v2ray-core/releases/latest)  
nginx：[https://nginx.org/en/download.html](https://nginx.org/en/download.html)  
win-acme：[https://www.win-acme.com](https://www.win-acme.com)  

## windows VPS配置

修改语言、关闭IE浏览器限制、关闭防火墙

------

win-acme申请证书的步骤

1. 先运行nginx
2. 运行win-acme
3. 选择m(full options)
4. 选择2手动输入
5. 输入域名后**回车**，确认域名**再次回车**
6. 选择认证方式1，on (network) path
7. 输入网站根目录，例如c:\nginx\html目录
8. 输出配置文件选择n
9. 密钥类型选择1Elli \*\*  key
10. 选择2(nginx,apache使用的)
11. 选择证书保存路径比如c:\zhengshu
12. 是否加密私钥，选择1,none
13. 是否保存其它位置，**直接回车**
14. 后面都直接回车默认就可以了
15. 保留-chain和-key文件，~~去除\*only\*和-crt文件~~

------

## v2ray配置信息

**vmess+ws+tls+web:**

```json
{
  "inbounds": [
    {
      "port": 8388,
      "listen":"127.0.0.1",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "c98ee1c3-5ea3-4fbf-a458-4c8393149f2a",
            "alterId": 0
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "path": "/ray"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
```

**nginx配置文件：**

```nginx
worker_processes  1;
events {
    worker_connections  1024;
}
http {
    server {
       listen 443 ssl http2;

       server_name win.buliang0.tk;  #你的域名
       ssl_certificate       C:\\Users\\Administrator\\Desktop\\v2ray-windows-64\\cer.pem;  #证书
       ssl_certificate_key   C:\\Users\\Administrator\\Desktop\\v2ray-windows-64\\key.pem; #私钥
       
       ssl_protocols         TLSv1.2 TLSv1.3;
       ssl_ciphers           ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
       ssl_prefer_server_ciphers off;

       location / {
           proxy_pass https://www.bing.com; #伪装网址
           proxy_ssl_server_name on;
           proxy_redirect off;
           sub_filter_once off;
           sub_filter "www.bing.com" $server_name;
           proxy_set_header Host "www.bing.com";
           proxy_set_header Referer $http_referer;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header User-Agent $http_user_agent;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto https;
           proxy_set_header Accept-Encoding "";
           proxy_set_header Accept-Language "zh-CN";
       }


       location /ray {
           proxy_redirect off;
           proxy_pass http://127.0.0.1:8388; #v2ray监听端口
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection "upgrade";
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       }
    }

    server {
        listen 80;

        location /.well-known/ {
               root   html;
            }
        location / {
            rewrite ^(.*)$ https://$host$1 permanent;
            }
    }

}
```

配置好之后，打开CMD，输入nginx -s reload

确认没有输出错误信息就可以了

最后客户端配置上网，注意路径/ray
