# 使用CFW的parsers功能自动插入负载均衡策略组实现多线程下载带宽叠加，完美配合CDN优选IP

## 视频文档

### 本地订阅转换

https://bulianglin.com/archives/51.html

### CFW自动添加负载均衡

```yaml
parsers:
  - reg: 'slbable$'
    yaml:
      append-proxy-groups:
        - name: ⚖️ 负载均衡-散列
          type: load-balance
          url: 'http://www.google.com/generate_204'
          interval: 300
          strategy: consistent-hashing
        - name: ⚖️ 负载均衡-轮询
          type: load-balance
          url: 'http://www.google.com/generate_204'
          interval: 300
          strategy: round-robin
      commands:
        - proxy-groups.⚖️ 负载均衡-散列.proxies=[]proxyNames
        - proxy-groups.0.proxies.0+⚖️ 负载均衡-散列
        - proxy-groups.⚖️ 负载均衡-轮询.proxies=[]proxyNames
        - proxy-groups.0.proxies.0+⚖️ 负载均衡-轮询
```

### 手动添加负载均衡

```yaml
#添加到第一个代理策略组
      - ⚖️ 负载均衡-轮询
      - ⚖️ 负载均衡-散列

#添加代理策略组
  - name: ⚖️ 负载均衡-散列
    type: load-balance
    url: http://www.google.com/generate_204
    interval: 300
    strategy: consistent-hashing
    proxies:
      - P1
      - P2
      - P3
  - name: ⚖️ 负载均衡-轮询
    type: load-balance
    url: http://www.google.com/generate_204
    interval: 300
    strategy: round-robin
    proxies:
      - P1
      - P2
      - P3
```

