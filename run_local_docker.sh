#!/bin/sh -uex
docker run --name hello_func1 --rm \
  -p 9000:8080 \
  func1:latest &
