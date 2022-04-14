#!/bin/bash
#docker exec -it gitlab_docker_gitlab_1 /sbin/entrypoint.sh app:rake gitlab:backup:create
rm -rf ../gitlab-data/builds
rm -rf ../gitlab-data/repositories
rm -rf ../gitlab-data/shared
rm -rf ../gitlab-data/ssh
rm -rf ../gitlab-data/tmp
rm -rf ../gitlab-data/uploads
rm -rf ../postgresql-data/
rm -rf ../redis-data/
rm -rf ../registry/
