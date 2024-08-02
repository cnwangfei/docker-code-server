# 停止所有的container 
docker stop $(docker ps -a -q)
# 删除所有container
docker rm $(docker ps -a -q)
# 删除none镜像
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
# 创建镜像
current_date=$(date +'%Y%m%d')
docker build --force-rm --no-cache -t cnwangfei/code-server:go1.22.5_coder4.91.1_${current_date} . --build-arg GOVERSION=1.22.5