#!/bin/bash
docker exec -it gitlab_docker_gitlab_1 /sbin/entrypoint.sh app:rake gitlab:check
