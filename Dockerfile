FROM alpine:3.14
RUN apk add asciidoc bash bc binutils bzip2 cdrkit coreutils diffutils findutils flex g++ gawk gcc gettext git grep intltool libxslt linux-headers make ncurses-dev openssl-dev patch perl python2-dev python3-dev rsync tar unzip util-linux wget zlib-dev sudo xz

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
ENV SDKVER openwrt-sdk-19.07.8-x86-64_gcc-7.5.0_musl.Linux-x86_64
ENV SDK_URL https://downloads.openwrt.org/releases/19.07.8/targets/x86/64/openwrt-sdk-19.07.8-x86-64_gcc-7.5.0_musl.Linux-x86_64.tar.xz
ENV SDK_SUFFIX .tar.xz

RUN wget -nv $SDK_URL
RUN tar xf "$(basename $SDK_URL)"
COPY config.buildinfo /home/$USR/$SDKVER/.config
RUN sudo chown $USR.$USR -R /home/$USR

WORKDIR /home/$USR
RUN tar -xf $SDKVER.tar.xz

WORKDIR /home/$USR/$SDKVER
RUN make defconfig
RUN ./scripts/feeds update -a
