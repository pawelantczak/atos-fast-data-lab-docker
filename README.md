## fast-data lab 
### This image contains below software stack:
- Spring Cloud Data Flow
- Kafka
- Elasticsearch
- Kibana

### You can access each service on below ports:
- Spring Cloud Data Flow - ```9393```
- Spring Cloud Data Flow Metrics Collector - ```9494``` ```user:"u" password:"p"```
- Kibana - ```5601```
- Kafka - ```not exposed```
- Elasticsearch - ```not exposed```

### Run via docker run:
```bash
docker run -i -t  -p 5601:5601 -p 9494:9494 -p 9393:9393 \ 
	--ulimit nofile=65536:65536 atos-fast-data-lab```