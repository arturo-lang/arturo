docker kill $(docker ps -q)
docker rm $(docker ps --filter=status=exited --filter=status=created -q)
docker rmi -f $(docker images -a -q)