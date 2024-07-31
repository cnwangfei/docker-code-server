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
  echo "**** install runtime dependencies ****" && \
  apt-get update && \
  apt-get install build-essential -y && \
  apt-get install -f -y && \
  echo "**** install code-server ****" && \
  if [ -z ${CODE_RELEASE+x} ]; then \
    CODE_RELEASE=$(curl -sX GET https://api.github.com/repos/coder/code-server/releases/latest \
      | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^v||'); \
  fi && \
  mkdir -p /app/code-server && \
  curl -o \
    /tmp/code-server.tar.gz -L \
    "https://github.com/coder/code-server/releases/download/v${CODE_RELEASE}/code-server-${CODE_RELEASE}-linux-amd64.tar.gz" && \
  tar xf /tmp/code-server.tar.gz -C \
    /app/code-server --strip-components=1 && \
  echo "**** clean up ****" && \
  apt-get clean && \
  rm -rf \
    /config/* \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* && \
    echo "**** set path ****" && \
    echo "export PATH=$PATH:/usr/local/go/bin" > /etc/profile 

# CMD ["/app/code-server/bin/code-server","--extensions-dir","/config/extensions","--user-data-dir",${DEFAULT_WORKSPACE},"--host","0.0.0.0","--port","8443"]
COPY run /app/code-server

CMD ["sh","/app/code-server/run"]

# ports and volumes
EXPOSE 8443