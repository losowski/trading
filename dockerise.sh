#!/bin/sh
# Build the docker images for the trading project

# Build Base Image
docker build -f BaseDockerfile -t tradingbase .
docker image tag tradingbase localhost:5000/tradingbase
docker push localhost:5000/tradingbase

# Build Complilation image
docker build -f Dockerfile -t trading .
docker image tag trading localhost:5000/trading
docker push localhost:5000/trading


# Build final symbol updater

# Build final symbol ticker



# Usage
#docker run -d --rm -p 9456:9456 opensshserver





#docker run -it --rm -p 9456:9456 pulsedev bash
#ssh eugene@localhost -p 9456

