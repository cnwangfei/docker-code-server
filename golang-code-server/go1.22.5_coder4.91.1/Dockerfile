ARG GOVERSION
FROM golang:${GOVERSION}

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CODE_RELEASE
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="cnWangFei"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

RUN \
  echo "**** install runtime dependencies ****" \
  && apt-get update \
  && apt-get install -y \
      build-essential \
      libwayland-dev \
      libx11-dev \
      libx11-xcb-dev \
      libxkbcommon-dev \
      libxkbcommon-x11-dev \
      libgles2-mesa-dev \
      libegl1-mesa-dev \
      libffi-dev \
      libxcursor-dev \
      libxrandr-dev \
      libxinerama-dev \
      libxi-dev \
      libxxf86vm-dev \
      libvulkan-dev \
      sudo \
  && apt-get install -f -y \
  && echo "**** install code-server ****" \
  && if [ -z ${CODE_RELEASE+x} ]; then \
        CODE_RELEASE=$(curl -sX GET https://api.github.com/repos/coder/code-server/releases/latest \
          | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^v||'); \
     fi \
  && mkdir -p /app/code-server \
  && curl -o \
      /tmp/code-server.tar.gz -L \
      "https://github.com/coder/code-server/releases/download/v${CODE_RELEASE}/code-server-${CODE_RELEASE}-linux-amd64.tar.gz" \
  && tar xf /tmp/code-server.tar.gz -C \
      /app/code-server --strip-components=1 \
  && echo "**** clean up ****" \
  && apt-get clean \
  && rm -rf \
      /config/* \
      /tmp/* \
      /var/lib/apt/lists/* \
      /var/tmp/* \
  && echo "**** set path ****" \
  && echo "export PATH=$PATH:/usr/local/go/bin" > /etc/profile \
  && echo "**** create user ****" \
  && adduser --gecos '' --disabled-password coder \
  && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd \
  && usermod -d ${HOME} coder \
  && echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /etc/bash.bashrc

COPY run /app/code-server


USER coder
ENV USER=coder
WORKDIR ${HOME}

# ports and volumes
EXPOSE 8443

CMD ["sh","/app/code-server/run"]