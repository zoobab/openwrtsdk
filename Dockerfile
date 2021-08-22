FROM alpine:3.14
RUN apk add asciidoc bash bc binutils bzip2 cdrkit coreutils diffutils findutils flex g++ gawk gcc gettext git grep intltool libxslt linux-headers make ncurses-dev openssl-dev patch perl python2-dev python3-dev rsync tar unzip util-linux wget zlib-dev sudo xz lighttpd curl

ENV USR openwrt
ENV GRP openwrt
ENV UID 2000
ENV GID 3000

RUN addgroup -g "$GID" -S "$GRP" && \
	adduser \
	--disabled-password \
	-g "$GID" \
	-D \
	-s "/bin/sh" \
	-h "/home/$USR" \
	-u "$UID" \
	-G "$GRP" "$USR" && exit 0 ; exit 1

RUN echo "$USR ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USR
RUN chmod 0440 /etc/sudoers.d/$USR

USER $USR
WORKDIR /home/$USR
ARG arch
ARG subarch
ARG relver
ENV SDK_URL https://downloads.openwrt.org/releases/${relver}/targets/${arch}/${subarch}/openwrt-sdk-${relver}-${arch}-${subarch}_gcc-8.4.0_musl_eabi.Linux-x86_64.tar.xz
ENV SDK_URL2 https://downloads.openwrt.org/releases/${relver}/targets/${arch}/${subarch}/openwrt-sdk-${relver}-${arch}-${subarch}_gcc-8.4.0_musl.Linux-x86_64.tar.xz
ENV SDK_URL3 https://downloads.openwrt.org/releases/${relver}/targets/${arch}/${subarch}/openwrt-sdk-${relver}-${arch}_gcc-8.4.0_musl.Linux-x86_64.tar.xz
ENV SDK_URL4 https://downloads.openwrt.org/releases/${relver}/targets/${arch}/${subarch}/openwrt-sdk-${relver}-${arch}_gcc-8.4.0_musl_eabi.Linux-x86_64.tar.xz
ENV SDK_URL5 https://downloads.openwrt.org/releases/${relver}/targets/${arch}/${subarch}/openwrt-sdk-${relver}-${arch}-${subarch}_gcc-8.4.0_glibc.Linux-x86_64.tar.xz
ENV SDK_SUFFIX .tar.xz

WORKDIR /home/$USR
RUN wget -nv $SDK_URL || wget -nv $SDK_URL2 || wget -nv $SDK_URL3 || wget -nv $SDK_URL4 || wget -nv $SDK_URL5 && export TARFILE="$(ls -1 *$SDK_SUFFIX)" &&\
    tar xf $TARFILE &&\
    rm $TARFILE &&\
    mv "$(basename $TARFILE $SDK_SUFFIX)" sdk &&\
    ln -s ../feeds/base/package/utils sdk/package/utils
#COPY config.buildinfo /home/$USR/sdk/.config
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
RUN sudo chown $USR.$USR -R /home/$USR

WORKDIR /home/$USR/sdk
RUN ./staging_dir/host/bin/usign -G -s ./key-build -p ./key-build.pub -c "Local build key"
RUN ./scripts/feeds update -a
RUN make defconfig
