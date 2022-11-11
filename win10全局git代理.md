# win10 全局git代理

国内使用github真是难，需要设置代理，每次都设置很麻烦，所以建议直接全局设置了。

以下为命令行修改代理

win10 全局git代理，这个命令需要在git shell中使用才有效

```
git config --global http.proxy socks5://127.0.0.1:1081
git config --get --global http.proxy
git config --global --unset http.proxy
```

以下命令会把代理加到系统的环境变量中，如果需要去除或者需要确认请去windows系统高级设置的环境变量页面查看

```
setx https_proxy socks5://127.0.0.1:1081
setx http_proxy socks5://127.0.0.1:1081
```

还可以在git配置文件，本地用户目录下新建.gitconfig，这个是在linux下使用的，请注意

配置文件方式：`~/.gitconfig`

```
[http]

proxy: http://127.0.0.1:2345

[https]

proxy: https://127.0.0.1:2344
```

另外给flutter设置国内源

```
setx PUB_HOSTED_URL https://pub.flutter-io.cn
setx FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
```



