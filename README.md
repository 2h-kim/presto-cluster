# Presto cluster with docker

## Test environment
- window 11
- docker : Docker version 20.10.17, build 100c701
- docker-compose : docker-compose version 1.29.2, build 5becea4c
- presto : 0.276.1


## Run
```bash
git clone https://github.com/2h-kim/presto-cluster.git

cd presto-cluster

# Set catalog
vim mysql.properties

docker-compose up -d
```

### Environment Value

| environment value | config file | value | default | 
| ---- | ---- | ---- | ---- | ---- |
| PRESTO_CONF_COORDINATOR | config.properties | coordinator | true |
| PRESTO_CONF_INCLUDE_COORDINATOR | config.properties | node-scheduler.include-coordinator | true |
| PRESTO_CONF_HTTP_PORT | config.properties | http-server.http.port | 8080 |
| PRESTO_CONF_QUERY_MAX_MEMORY | config.properties | query.max-memory | 5GB |
| PRESTO_CONF_QUERY_MAX_MEMORY_PER_NODE | config.properties | query.max-memory-per-node | 1GB |
| PRESTO_CONF_QUERY_MAX_TOTAL_MEMORY_PER_NODE | config.properties | query.max-total-memory-per-node | 2GB |
| PRESTO_CONF_DISCOVERY_SERVER_ENABLED | config.properties | discovery-server.enabled | true |
| PRESTO_CONF_DISCOVERY_URI | config.properties | discovery.uri | http://localhost:8080
vPRESTO_JVM_MEMORY_MS_MX | jvm.config | - | 16G |
| PRESTO_JVM_H1_HEAP_REGION_SIZE | jvm.config | - | 32M |
| PRESTO_LOG_LEVEL | log.properties | com.facebook.presto | INFO |
| PRESTO_NODE_ENV | node.properties | node.environment | INFO |
| PRESTO_NODE_ID | node.properties | node.id | uuidgen |
