#!/usr/bin/env bash

# configure
# config.properties
: "${PRESTO_CONF_COORDINATOR:=true}"
: "${PRESTO_CONF_INCLUDE_COORDINATOR:=true}"
: "${PRESTO_CONF_HTTP_PORT:=8080}"
: "${PRESTO_CONF_QUERY_MAX_MEMORY:=5GB}"
: "${PRESTO_CONF_QUERY_MAX_MEMORY_PER_NODE:=1GB}"
: "${PRESTO_CONF_QUERY_MAX_TOTAL_MEMORY_PER_NODE:=2GB}"
: "${PRESTO_CONF_DISCOVERY_SERVER_ENABLED:=true}"
: "${PRESTO_CONF_DISCOVERY_URI:=http://localhost:8080}"

# write config properties function
presto_config_properties()
{
    echo "coordinator=${PRESTO_CONF_COORDINATOR}"
    echo "http-server.http.port=${PRESTO_CONF_HTTP_PORT}"
    echo "query.max-memory=${PRESTO_CONF_QUERY_MAX_MEMORY}"
    echo "query.max-memory-per-node=${PRESTO_CONF_QUERY_MAX_MEMORY_PER_NODE}"
    echo "query.max-total-memory-per-node=${PRESTO_CONF_QUERY_MAX_TOTAL_MEMORY_PER_NODE}"
    echo "discovery.uri=${PRESTO_CONF_DISCOVERY_URI}"

    # if coordinator
    if [ $PRESTO_CONF_COORDINATOR == "true" ]; then
        echo "discovery-server.enabled=${PRESTO_CONF_DISCOVERY_SERVER_ENABLED}"
        echo "node-scheduler.include-coordinator=${PRESTO_CONF_INCLUDE_COORDINATOR}"
    fi
} > "${PRESTO_SERVER_HOME}/etc/config.properties"

# jvm.config
: "${PRESTO_JVM_MEMORY_MS_MX:=16G}"
: "${PRESTO_JVM_H1_HEAP_REGION_SIZE:=32M}"

# write jvm config function
presto_jvm_config()
{
    echo -e "-server \n\
    -Xmx${PRESTO_JVM_MEMORY_MS_MX} \n\
    -XX:+UseG1GC \n\
    -XX:G1HeapRegionSize=${PRESTO_JVM_H1_HEAP_REGION_SIZE} \n\
    -XX:+UseGCOverheadLimit \n\
    -XX:+ExplicitGCInvokesConcurrent \n\
    -XX:+HeapDumpOnOutOfMemoryError \n\
    -XX:+ExitOnOutOfMemoryError \n\
    -Djdk.attach.allowAttachSelf=true"
} > "${PRESTO_SERVER_HOME}/etc/jvm.config"


# log.properties
: "${PRESTO_LOG_LEVEL:=INFO}"
presto_log_properties()
{
    echo "com.facebook.presto=${PRESTO_LOG_LEVEL}"
} > "${PRESTO_SERVER_HOME}/etc/log.properties"

# node.properties
: "${PRESTO_NODE_ENV:=docker}"
: "${PRESTO_NODE_ID:=$(uuidgen)}"

presto_node_properties()
{
    echo "node.environment=${PRESTO_NODE_ENV}"
    echo "node.id=${PRESTO_NODE_ID}"
    echo "node.data-dir=${PRESTO_LOG_DIRECTORY}"
} > "${PRESTO_SERVER_HOME}/etc/node.properties"


# config generate
presto_config_properties
presto_jvm_config
presto_log_properties
presto_node_properties

echo "${PRESTO_SERVER_HOME}/bin/launcher run"
${PRESTO_SERVER_HOME}/bin/launcher run