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

# download presto
wget https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.276.1/presto-server-0.276.1.tar.gz
tar -xvzf presto-server-0.276.1.tar.gz
cp presto-server-0.276.1/* presto-coordinator/presto-coordi/ -r
cp presto-server-0.276.1/* presto-worker/presto-worker/ -r

# [optional] change configure
vim presto-worker/presto-worker/etc/log.properties
vim presto-worker/presto-worker/etc/jvm.config
...

# Set catalog
vim mysql.properties

docker-compose up -d
```