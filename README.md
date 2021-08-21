# OpenWRT PPA: How to build the SDK docker image

```
$ ./build.sh sunxi cortexa8 21.02.0-rc4
```

## Screenshot

## Output

It should generate a bunch of docker images:

```
$ docker images | grep sdk
zoobab/openwrtsdk                       21.02.0-rc4-x86-generic      130f8fc57af7   8 minutes ago        1.94GB
zoobab/openwrtsdk                       21.02.0-rc4-sunxi-cortexa8   452485aedd8f   11 hours ago         1.67GB
zoobab/openwrtsdk                       21.02.0-rc4-x86-64           c710087cb0ea   12 hours ago         2.21GB
```

## Problems

* How to handle the `eabi` which is not present in the URLs for x86?
