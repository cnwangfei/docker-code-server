docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
docker build --force-rm --no-cache -t code-server:23022601-coder4.10.0-golang1.19.6 .
