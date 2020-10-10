#!/bin/sh
# Build the docker images for the trading project

# Build Base Image
docker build -f BaseDockerfile -t tradingbase .
docker tag tradingbase localhost:10000/tradingbase
docker push localhost:10000/tradingbase

# Build Complilation image

# Build final symbol updater

# Build final symbol ticker



# Usage
#docker run -d --rm -p 9456:9456 opensshserver





#docker run -it --rm -p 9456:9456 pulsedev bash
#ssh eugene@localhost -p 9456

