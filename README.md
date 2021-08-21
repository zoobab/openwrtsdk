# OpenWRT PPA: How to build the SDK docker image

```
$ ./build.sh sunxi cortexa8 21.02.0-rc4
Sending build context to Docker daemon  76.29kB
Step 1/24 : FROM alpine:3.14
 ---> 021b3423115f
Step 2/24 : RUN apk add asciidoc bash bc binutils bzip2 cdrkit coreutils diffutils findutils flex g++ gawk gcc gettext git gre
p intltool libxslt linux-headers make ncurses-dev openssl-dev patch perl python2-dev python3-dev rsync tar unzip util-linux wg
et zlib-dev sudo xz lighttpd curl
 ---> Using cache
 ---> 5112cf1f7c67
Step 3/24 : ENV USR openwrt
 ---> Using cache
 ---> 6b3d85dcb6dc
Step 4/24 : ENV GRP openwrt
 ---> Using cache
 ---> 255c9d8afb9d
Step 5/24 : ENV UID 2000
 ---> Using cache
 ---> 07c6389840b4
 ---> Using cache
 ---> 3a8df872695c
Step 9/24 : RUN chmod 0440 /etc/sudoers.d/$USR
 ---> Using cache
 ---> c3495da122a8
Step 10/24 : USER $USR
 ---> Using cache
 ---> 4d9c8b5c2bff
Step 11/24 : WORKDIR /home/$USR
 ---> Using cache
 ---> 9d8cb76441ba
Step 12/24 : ARG arch
 ---> Using cache
 ---> 60f43a14aabe
Step 13/24 : ARG subarch
 ---> Using cache
 ---> 125a32aac28c
Step 14/24 : ARG relver
 ---> Using cache
 ---> 316e98dda36b
Step 15/24 : ENV SDK_URL https://downloads.openwrt.org/releases/${relver}/targets/${arch}/${subarch}/openwrt-sdk-${relver}-${arch}-${subarch}_gcc-8.4.0_musl_e
abi.Linux-x86_64.tar.xz
 ---> Running in fe35e398898e
Removing intermediate container fe35e398898e
 ---> f33e722f5a51
Step 16/24 : ENV SDK_SUFFIX .tar.xz
 ---> Running in 367e712ecd7a
Removing intermediate container 367e712ecd7a
 ---> 752f51f1c5cb
Step 17/24 : WORKDIR /home/$USR
 ---> Running in d0ad78772e68
Removing intermediate container d0ad78772e68
 ---> 2979db70b847
Step 18/24 : RUN wget -nv $SDK_URL &&    tar xf "$(basename $SDK_URL)" &&    rm "$(basename $SDK_URL)" &&    mv "$(basename $SDK_URL $SDK_SUFFIX)" sdk &&    l
n -s ../feeds/base/package/utils sdk/package/utils
 ---> Running in b004db8dfec7
2021-08-21 08:18:47 URL:https://downloads.openwrt.org/releases/21.02.0-rc4/targets/sunxi/cortexa8/openwrt-sdk-21.02.0-rc4-sunxi-cortexa8_gcc-8.4.0_musl_eabi.L
inux-x86_64.tar.xz [90134772/90134772] -> "openwrt-sdk-21.02.0-rc4-sunxi-cortexa8_gcc-8.4.0_musl_eabi.Linux-x86_64.tar.xz" [1]

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
