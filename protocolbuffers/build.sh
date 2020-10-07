#!/bin/sh
#Build the protocol buffer files
# Stock Price Service 
protoc  --python_out=../python/proto stock-price.proto

