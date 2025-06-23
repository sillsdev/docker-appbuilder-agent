# sillsdev/docker-appbuilder-agent

[AWS CodeBuild](https://aws.amazon.com/codebuild/) build agent for [AppBuilder BuildEngine API](/sillsdev/appbuilder-buildengine-api).

## Inspecting

To look around in the production image (from master branch), run:

    docker pull ghcr.io/sillsdev/appbuilder-agent-prd
    docker run --rm -it ghcr.io/sillsdev/appbuilder-agent-prd /sbin/my_init -- bash -l

To look around in the staging image (from develop branch), run:

    docker pull ghcr.io/sillsdev/appbuilder-agent-stg
    docker run --rm -it ghcr.io/sillsdev/appbuilder-agent-stg /sbin/my_init -- bash -l

## Local Build

To build locally and look around, run:

    docker build -t appbuilder-codebuild .
    docker run --rm -it appbuilder-codebuild /sbin/my_init -- bash -l
