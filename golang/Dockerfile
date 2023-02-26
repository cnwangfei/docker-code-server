# 选择code-server版本
ARG CodeVersion=4.10.0
FROM linuxserver/code-server:$CodeVersion

MAINTAINER cnwangfei

# 选择golang版本
ARG GoName=go1.19.6.linux-amd64.tar.gz

RUN apt-get update \
    && apt-get install -y \
	wget \
	gcc \
	&& wget https://golang.google.cn/dl/$GoName \
	&& rm -rf /usr/local/go && tar -C /usr/local -xzf $GoName \
	&& echo "export PATH=$PATH:/usr/local/go/bin:/config/go/bin" > /etc/profile.d/path.sh \
	&& rm $GoName \
	&& apt-get remove -y \
	wget \
	&& apt-get autoremove \
	&& apt-get clean