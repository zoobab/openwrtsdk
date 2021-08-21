# OpenWRT PPA: How to build the SDK docker image

This `build.sh` creates a docker image with the OpenWRT SDK of your choice, that can be reused/cached with the `openwrtsdkbuild` repo (see https://github.com/zoobab/openwrtsdkbuild).

## Available docker images

* [https://hub.docker.com/layers/zoobab/openwrtsdk/21.02.0-rc4-sunxi-cortexa8/images/sha256-cd7e159eef2942f842ceb5acd23dfdc12e8c49fbd8cb8da5f3ebf791d4c3a81a?context=explore zoobab/openwrtsdk:21.02.0-rc4-sunxi-cortexa8]

## Screenshot

```
$ ./build.sh
Usage: ./build.sh arch subarch relver
Example: ./build.sh sunxi cortexa8 21.02.0-rc4

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
Removing intermediate container b004db8dfec7
 ---> 6b028533eac8
Step 19/24 : COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
 ---> 4e4f386f5706
Step 20/24 : RUN sudo chown $USR.$USR -R /home/$USR
 ---> Running in b3c50fef5539
Removing intermediate container b3c50fef5539
 ---> bdb936349e61
Step 21/24 : WORKDIR /home/$USR/sdk
 ---> Running in 3fc2211ee7df
Removing intermediate container 3fc2211ee7df
 ---> 55bb36008946
Step 22/24 : RUN ./staging_dir/host/bin/usign -G -s ./key-build -p ./key-build.pub -c "Local build key"
 ---> Running in 833f76045a11
Removing intermediate container 833f76045a11
 ---> f576c8b657d9
Step 23/24 : RUN ./scripts/feeds update -a
 ---> Running in e7cce982e44e
Updating feed 'base' from 'https://git.openwrt.org/openwrt/openwrt.git;v21.02.0-rc4' ...
Cloning into './feeds/base'...
Note: switching to '134ac824c5a154edbbe1c581bcbc42d265dc20c0'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

Create index file './feeds/base.index'
Checking 'working-make'... ok.
Checking 'case-sensitive-fs'... ok.
Checking 'proper-umask'... ok.
Checking 'gcc'... ok.
Checking 'working-gcc'... ok.
Checking 'g++'... ok.
Checking 'working-g++'... ok.
Checking 'ncurses'... ok.
Checking 'perl-data-dumper'... ok.
Checking 'perl-findbin'... ok.
Checking 'perl-file-copy'... ok.
Checking 'perl-file-compare'... ok.
Checking 'perl-thread-queue'... ok.
Checking 'tar'... ok.
Checking 'find'... ok.
Checking 'bash'... ok.
Checking 'xargs'... ok.
Checking 'patch'... ok.
Checking 'diff'... ok.
Checking 'cp'... ok.
Checking 'seq'... ok.
Checking 'awk'... ok.
Checking 'grep'... ok.
Checking 'egrep'... ok.
Checking 'getopt'... ok.
Checking 'stat'... ok.
Checking 'unzip'... ok.
Checking 'bzip2'... ok.
Checking 'wget'... ok.
Checking 'perl'... ok.
Checking 'python2-cleanup'... ok.
Checking 'python'... ok.
Checking 'python3'... ok.
Checking 'git'... ok.
Checking 'file'... ok.
Checking 'rsync'... ok.
Checking 'which'... ok.
Checking 'ldconfig-stub'... ok.
Collecting package info: done
Collecting target info: done
Updating feed 'packages' from 'https://git.openwrt.org/feed/packages.git^49b1a6f4cc6e265cb98eb3d3225aca96079d1ec0' ...
Cloning into './feeds/packages'...
Switched to a new branch '49b1a6f4cc6e265cb98eb3d3225aca96079d1ec0'

/home/openwrt/sdk
Create index file './feeds/luci.index'
Collecting package info: done
Collecting target info: done
Updating feed 'routing' from 'https://git.openwrt.org/feed/routing.git^e7e25b873b8ed4376cdcf82f963db34dda954f02' ...
Cloning into './feeds/routing'...
Switched to a new branch 'e7e25b873b8ed4376cdcf82f963db34dda954f02'
/home/openwrt/sdk
Create index file './feeds/routing.index'
Collecting package info: done
Collecting target info: done
Updating feed 'telephony' from 'https://git.openwrt.org/feed/telephony.git^aa1954024371e02d985b51ec4187fc0745ab4e18' ...
Cloning into './feeds/telephony'...
Switched to a new branch 'aa1954024371e02d985b51ec4187fc0745ab4e18'
/home/openwrt/sdk
Create index file './feeds/telephony.index'
Collecting package info: done
Collecting target info: done
Removing intermediate container e7cce982e44e
 ---> 6861dd3aa278
Step 24/24 : RUN make defconfig
 ---> Running in be067bd59dff
WARNING: Makefile 'package/utils/adb/Makefile' has a dependency on 'zlib', which does not exist
WARNING: Makefile 'package/utils/adb/Makefile' has a dependency on 'libopenssl', which does not exist
WARNING: Makefile 'package/utils/busybox/Makefile' has a dependency on 'libpam', which does not exist
WARNING: Makefile 'package/utils/busybox/Makefile' has a dependency on 'libpam', which does not exist
WARNING: Makefile 'package/utils/busybox/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/busybox/Makefile' has a build dependency on 'libpam', which does not exist
WARNING: Makefile 'package/utils/checkpolicy/Makefile' has a build dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/checkpolicy/Makefile' has a build dependency on 'libselinux/host', which does not exist
WARNING: Makefile 'package/utils/f2fs-tools/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/f2fs-tools/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/f2fs-tools/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/f2fs-tools/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/fritz-tools/Makefile' has a dependency on 'zlib', which does not exist
WARNING: Makefile 'package/utils/jsonfilter/Makefile' has a dependency on 'libubox', which does not exist
WARNING: Makefile 'package/utils/jsonfilter/Makefile' has a dependency on 'libjson-c', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'eip197-mini-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'r8169-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'e100-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'bnx2-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'bnx2x-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'ar3k-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'mwifiex-sdio-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'kmod-phy-bcm-ns-usb2', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'edgeport-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'kmod-phy-bcm-ns-usb3', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'amdgpu-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'radeon-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'prism54-firmware', which does not exist
WARNING: Makefile 'package/kernel/linux/Makefile' has a dependency on 'rtl8192su-firmware', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libsepol', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libaudit', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libsepol', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libaudit', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libaudit', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libpam', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libsemanage', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libaudit', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libpam', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libsemanage', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libselinux', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libsemanage', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libsepol', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a dependency on 'libintl-full', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a build dependency on 'libpam', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a build dependency on 'gettext-full/host', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a build dependency on 'libiconv', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a build dependency on 'gettext', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a build dependency on 'libsemanage/host', which does not exist
WARNING: Makefile 'package/utils/policycoreutils/Makefile' has a build dependency on 'gettext-full/host', which does not exist
WARNING: Makefile 'package/utils/px5g-mbedtls/Makefile' has a dependency on 'libmbedtls', which does not exist
WARNING: Makefile 'package/utils/px5g-wolfssl/Makefile' has a dependency on 'libwolfssl', which does not exist
WARNING: Makefile 'package/utils/secilc/Makefile' has a dependency on 'libsepol', which does not exist
WARNING: Makefile 'package/utils/secilc/Makefile' has a build dependency on 'libiconv', which does not exist
WARNING: Makefile 'package/utils/secilc/Makefile' has a build dependency on 'gettext', which does not exist
WARNING: Makefile 'package/utils/secilc/Makefile' has a build dependency on 'libsepol/host', which does not exist
WARNING: Makefile 'package/utils/ugps/Makefile' has a dependency on 'libubox', which does not exist
WARNING: Makefile 'package/utils/ugps/Makefile' has a dependency on 'libubus', which does not exist
WARNING: Makefile 'package/utils/usbmode/Makefile' has a dependency on 'libubox', which does not exist
WARNING: Makefile 'package/utils/usbmode/Makefile' has a dependency on 'libblobmsg-json', which does not exist
WARNING: Makefile 'package/utils/usbmode/Makefile' has a dependency on 'libusb-1.0', which does not exist
WARNING: Makefile 'package/utils/util-linux/Makefile' has a dependency on 'libncurses', which does not exist
WARNING: Makefile 'package/utils/util-linux/Makefile' has a dependency on 'libncurses', which does not exist
WARNING: Makefile 'package/utils/util-linux/Makefile' has a dependency on 'libncursesw', which does not exist
WARNING: Makefile 'package/utils/util-linux/Makefile' has a dependency on 'libncursesw', which does not exist
WARNING: Makefile 'package/utils/util-linux/Makefile' has a dependency on 'libncurses', which does not exist
WARNING: Makefile 'package/utils/util-linux/Makefile' has a dependency on 'libncurses', which does not exist
WARNING: Makefile 'package/utils/util-linux/Makefile' has a dependency on 'libncursesw', which does not exist
tmp/.config-package.in:26:warning: ignoring type redefinition of 'PACKAGE_busybox' from 'bool' to 'tristate'
tmp/.config-package.in:60:warning: ignoring type redefinition of 'PACKAGE_jsonfilter' from 'bool' to 'tristate'
tmp/.config-package.in:139:warning: ignoring type redefinition of 'PACKAGE_libc' from 'bool' to 'tristate'
tmp/.config-package.in:167:warning: ignoring type redefinition of 'PACKAGE_libgcc' from 'bool' to 'tristate'
tmp/.config-package.in:288:warning: ignoring type redefinition of 'PACKAGE_libpthread' from 'bool' to 'tristate'
tmp/.config-package.in:316:warning: ignoring type redefinition of 'PACKAGE_librt' from 'bool' to 'tristate'
tmp/.config-package.in:597:warning: ignoring type redefinition of 'PACKAGE_lua' from 'bool' to 'tristate'
tmp/.config-package.in:697:warning: ignoring type redefinition of 'PACKAGE_libblkid' from 'bool' to 'tristate'
tmp/.config-package.in:713:warning: ignoring type redefinition of 'PACKAGE_libcomerr' from 'bool' to 'tristate'
tmp/.config-package.in:727:warning: ignoring type redefinition of 'PACKAGE_libext2fs' from 'bool' to 'tristate'
tmp/.config-package.in:743:warning: ignoring type redefinition of 'PACKAGE_libf2fs' from 'bool' to 'tristate'
tmp/.config-package.in:783:warning: ignoring type redefinition of 'PACKAGE_liblua' from 'bool' to 'tristate'
tmp/.config-package.in:824:warning: ignoring type redefinition of 'PACKAGE_libsmartcols' from 'bool' to 'tristate'
tmp/.config-package.in:837:warning: ignoring type redefinition of 'PACKAGE_libss' from 'bool' to 'tristate'
tmp/.config-package.in:851:warning: ignoring type redefinition of 'PACKAGE_libuuid' from 'bool' to 'tristate'
tmp/.config-package.in:1029:warning: ignoring type redefinition of 'PACKAGE_partx-utils' from 'bool' to 'tristate'
tmp/.config-package.in:1105:warning: ignoring type redefinition of 'PACKAGE_px5g-wolfssl' from 'bool' to 'tristate'
tmp/.config-package.in:1186:warning: ignoring type redefinition of 'PACKAGE_e2fsprogs' from 'bool' to 'tristate'
tmp/.config-package.in:1318:warning: ignoring type redefinition of 'PACKAGE_mkf2fs' from 'bool' to 'tristate'
#
# configuration written to .config
#
Removing intermediate container be067bd59dff
 ---> 4c77d1233e9f
Successfully built 4c77d1233e9f
Successfully tagged zoobab/openwrtsdk:21.02.0-rc4-sunxi-cortexa8
```

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
* Generate all docker images with all SDKs with a script
