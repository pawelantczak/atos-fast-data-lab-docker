## fast-data lab 
### This image contains below software stack:
- Spring Cloud Data Flow
- Kafka
- Elasticsearch
- Kibana

### You can access each service on below ports:
- Spring Cloud Data Flow - ```localhost:9393```
- Kibana - ```localhost:5601```
- Spring Cloud Data Flow Metrics Collector - ```localhost:9494``` ```user:"u" password:"p"```
- Kafka - ```not exposed```
- Elasticsearch - ```not exposed```

### Run via docker run:
```bash
docker run -i -t  -p 5601:5601 -p 9494:9494 -p 9393:9393 \ 
	--ulimit nofile=65536:65536 atosgdcpolska/fast-data-lab
```
