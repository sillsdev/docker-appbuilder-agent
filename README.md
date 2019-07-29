# silintl/appbuilder-agent #

[AWS CodeBuild](https://aws.amazon.com/codebuild/) build agent for [AppBuilder BuildEngine API](/sillsdev/appbuilder-buildengine-api).

## Inspecting

To look around in the image, run:

    docker pull sillsdev/appbuilder-agent:production
    docker run --rm -it sillsdev/appbuilder-agent:production /sbin/my_init -- bash -l

## Local Build

To build locally and look around, run:

    docker build -t appbuilder-codebuild .
    docker run --rm -it appbuilder-codebuild /sbin/my_init -- bash -l
