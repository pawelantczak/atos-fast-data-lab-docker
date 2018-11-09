#!/bin/bash

docker run -i -t  -p 5601:5601 -p 8080:8080 -p 9494:9494 -p 9393:9393 --ulimit nofile=65536:65536 atos-fast-data-lab
