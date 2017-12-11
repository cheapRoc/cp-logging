# cp-logging

Use to debug logging through ContainerPilot.

1. Add output to log into `outputs/`
1. `docker build -t cp-logging .`
1. `docker run --name cptest cp-logging containerpilot`
1. Either look at `docker logs` or possibly output from `triton-docker run` itself.
1. ContainerPilot will log output and complete.
1. `docker rm cptest` when completed.

If you need a long running container then add a `while true` loop around the `for` loop inside the shell script. This should allow a container to continually output the same set of log files repeatedly.

This should also work the same way under Docker for Mac or Docker Machine.
