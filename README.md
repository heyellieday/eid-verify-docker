# Docker based verifier for eID signed docs
----
Proof of concept for having a containerized process for verifying signed documents from eID holders.

It's really just a Dockerfile right now.

Uses [https://github.com/open-eid/libdigidocpp](libdigidocpp) under the hood, which is maintained by Estonia

## Steps to run locally, assuming you have docker set up.

### Docker build step:

`docker build --tag estoniaodao-verify:0.3 .`

### Enter into bash of container w/ verify lib:

`docker run -it --name ee1 estoniaodao-verify:0.3 /bin/bash`

### Command to run in container to verify and unlock file:

`/usr/local/bin/digidoc-tool open container-file.asice --extractAll`

You can get a file to open from IPFS by downloading via curl like so:

`curl https://url -o file.name`


## TODO

- Lots of things!
- Optimize Dockerfile layers