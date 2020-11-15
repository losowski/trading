#!/bin/sh
#Build the protocol buffer files
# Stock Price Service 
protoc  --python_out=../python/proto stockticker.proto
protoc  --python_out=../python/proto stockdetails.proto
