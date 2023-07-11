#!/bin/bash

REGION="ap-northeast-2"
ECR_REPOSITOY="257307634175.dkr.ecr.ap-northeast-2.amazonaws.com"
ECR_DOCKER_IMAGE="${ECR_REPOSITORY}/aws07-spring-petclinic"
ECR_DOCKER_TAG="1.0"

aws ecr get-login-password --region ${REGION} \
  | docker login --username AWS --password-stdin ${ECR_REPOSITORY};

export IMAGE= ${ECR_DOCKER_IMAGE};
export TAG=${ECR_DOCKER_TAG};
docker-compose -f /home/ubuntu/docker-compose.yml up -d;
