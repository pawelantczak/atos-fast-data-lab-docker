#!/bin/bash

docker run -t -i -p 5601:5601 -p 9494:9494 -p 9393:9393 --ulimit nofile=65536:65536 atos-fast-data-lab
