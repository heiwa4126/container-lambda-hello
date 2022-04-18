#!/bin/sh -uex
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
# この変なURLは決め打ち。たぶんRIEの都合
