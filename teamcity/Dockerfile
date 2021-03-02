FROM jetbrains/teamcity-agent
USER root
RUN apt update 
RUN apt install -y amazon-ecr-credential-helper jq
RUN mkdir -p /home/buildagant/.docker /home/buildagent/bin
WORKDIR /home/buildagent
RUN curl https://raw.githubusercontent.com/silinternational/ecs-deploy/master/ecs-deploy > bin/ecs-deploy && chmod +x bin/ecs-deploy
COPY --from=amazon/aws-cli /usr/local /usr/local
COPY --from=amazon/aws-cli /aws /aws
ADD dot.docker/config.json .docker/config.json
USER buildagent
