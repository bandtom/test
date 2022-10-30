# 免费提升垃圾VPS线路速度，优选CF不存在的IP，速度提升巨大，延迟堪比专线，且用且珍惜

OpenBullet1使用教程：https://bulianglin.com/archives/48.html

安装xui：`bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)`

CF优选IP工具：[https://github.com/XIU2/CloudflareSpeedTest/releases/latest](https://github.com/XIU2/CloudflareSpeedTest/releases/latest)

反代CF的IP：[https://github.com/ip-scanner/cloudflare](https://github.com/ip-scanner/cloudflare)

合并txt文件：`type *.txt>>all.txt`

OpenBullet2：[https://github.com/openbullet/OpenBullet2/releases/latest](https://github.com/openbullet/OpenBullet2/releases/latest)

CF节点信息：`/cdn-cgi/trace`

机场三字码查询：[http://airport.anseo.cn/](https://bulianglin.com/g/aHR0cDovL2FpcnBvcnQuYW5zZW8uY24v)

**loli脚本：**

```nginx
BLOCK:HttpRequest
  url = $"http://<input.DATA>/cdn-cgi/trace"
  maxNumberOfRedirects = 2
  customHeaders = {("Host", "cf.nicename.tk")}
  timeoutMilliseconds = 3000
  TYPE:STANDARD
  $""
  "application/x-www-form-urlencoded"
ENDBLOCK

BLOCK:Keycheck
  banIfNoMatch = False
  KEYCHAIN SUCCESS OR
    STRINGKEY @data.SOURCE Contains "h=cf.nicename.tk"
ENDBLOCK
```



