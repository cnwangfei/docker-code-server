# 停止所有的container 
docker stop $(docker ps -a -q)
# 删除所有container
docker rm $(docker ps -a -q)
# 删除none镜像
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
# 创建镜像
docker build --force-rm --no-cache -t cnwangfei/code-server:go1.19.13_coder4.91.1 . --build-arg GOVERSION=1.19.13