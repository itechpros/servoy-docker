Supported tags and respective Dockerfile links
===============================================
## Standard Servoy 5-8 deployment
* servoy-oraclejava  [(oraclejava/servoy_generic/Dockerfile) ](https://github.com/goldcougar/servoy-docker/blob/oraclejava/servoy_generic/Dockerfile)

## Tomcat for Servoy WAR deployment
* tomcat-oraclejava  [(oraclejava/tomcat/Dockerfile) ](https://github.com/goldcougar/servoy-docker/blob/oraclejava/tomcat/Dockerfile)  

 

Examples of extending the above tags
===============================================
Note: These are examples showing how to use the tags.  You should create your own Dockerfiles using these as examples, but only extend from the above 2 main tags.

## Standard Servoy 8 deployment pointing to hosted cloud DB
* servoy_generic_demo_preconfigured  [(oraclejava/servoy_generic_demo_preconfigured/Dockerfile) ](https://github.com/goldcougar/servoy-docker/blob/oraclejava/servoy_generic_demo_preconfigured/Dockerfile)

## Standard Servoy 8 deployment and a Postgres deployment
Designed to be bundled together with Docker Compose, Docker Cloud, or other orchestration tool.
This will deploy the Servoy Sample CRM for the Servoy Web Client.
* servoy_generic_demo_dynamic_db  [(oraclejava/demo/servoy_generic_dynamic_db/Dockerfile) ](https://github.com/goldcougar/servoy-docker/blob/oraclejava/demo/servoy_generic_dynamic_db/Dockerfile)
* servoy_generic_demo_dynamic_db_pg  [(oraclejava/demo/servoy_generic_dynamic_db/postgres/Dockerfile) ](https://github.com/goldcougar/servoy-docker/blob/oraclejava/demo/servoy_generic_dynamic_db/postgres/Dockerfile)

**Docker Compose file for above deployment:**
docker-compose.yml
```YAML
version: '3'
services:
  servoy:
    container_name: Servoy8
    image: 'itechpros/servoy:servoy_generic_demo_dynamic_db'
    environment:
      - JAVA_XMS=128m
      - JAVA_XMX=1024m
    links:
      - db
    depends_on:
       - db
    ports:
      - '8080:8080'
  db:
    container_name: Postgres
    image: 'itechpros/servoy:servoy_generic_demo_dynamic_db_pg'
    environment:
      - POSTGRES_DB=servoyworld_2017
      - POSTGRES_PASSWORD=demo
```  
  
**Docker Cloud file for above deployment:**
docker-cloud.yml
```YAML
db:
  environment:
    - POSTGRES_DB=servoyworld_2017
    - POSTGRES_PASSWORD=demo
  image: 'itechpros/servoy:servoy_generic_demo_dynamic_db_pg'
servoy:
  environment:
    - JAVA_XMS=128m
    - JAVA_XMX=1024m
  image: 'itechpros/servoy:servoy_generic_demo_dynamic_db'
  links:
    - db
  ports:
    - '8080:8080'
```
 

## Tomcat Servoy 8 WAR deployment pointing to hosted cloud DB
* servoy_war_demo_preconfigured  [(oraclejava/demo/servoy_war_preconfigured/Dockerfile) ](https://github.com/goldcougar/servoy-docker/blob/oraclejava/demo/servoy_war_preconfigured/Dockerfile)

## Tomcat Servoy 8 WAR deployment and a Postgres deployment
Designed to be bundled together with Docker Compose, Docker Cloud, or other orchestration tool.
This will deploy the Servoy Sample CRM for the Servoy NGClient.
* servoy_war_demo_dynamic_db  [(oraclejava/demo/servoy_war_dynamic_db/Dockerfile) ](https://github.com/goldcougar/servoy-docker/blob/oraclejava/demo/servoy_war_dynamic_db/Dockerfile)
* servoy_war_demo_dynamic_db_pg  [(oraclejava/demo/servoy_war_dynamic_db/postgres/Dockerfile) ](https://github.com/goldcougar/servoy-docker/blob/oraclejava/demo/servoy_war_dynamic_db/postgres/Dockerfile)


**Docker Compose file for above deployment:**
docker-compose.yml
```YAML
version: '3'
services:
  servoy:
    container_name: Servoy8
    image: 'itechpros/servoy:servoy_war_demo_dynamic_db'
    environment:
      - JAVA_XMS=128m
      - JAVA_XMX=1024m
    links:
      - db
    depends_on:
       - db
    ports:
      - '8080:8080'
  db:
    container_name: Postgres
    image: 'itechpros/servoy:servoy_war_demo_dynamic_db_pg'
    environment:
      - POSTGRES_DB=servoyworld_2017
      - POSTGRES_PASSWORD=demo
```  
 
  
**Docker Cloud file for above deployment:**
docker-cloud.yml
```YAML
db:
  environment:
    - POSTGRES_DB=servoyworld_2017
    - POSTGRES_PASSWORD=demo
  image: 'itechpros/servoy:servoy_war_demo_dynamic_db_pg'
servoy:
  environment:
    - JAVA_XMS=128m
    - JAVA_XMX=1024m
  image: 'itechpros/servoy:servoy_war_demo_dynamic_db'
  links:
    - db
  ports:
    - '8080:8080'
```
 
Misc Notes
===============================================
Remember that your Docker containers loos their data after restart.  This is fine for Servoy applications servers, as they should be storing any persistent data beyond what you setup in your Dockerfile.  However for your Datbase servers, considering adding a volume to your Docker Compose or Docker Cloud file so that the storage location for the data is mapped to a fixed location on the parent host machine.  This way it will start up and always look to the same folder for its database data.  Keep in mind this only works if you do 1 database server per Docker host, otherwise you'll need to choose different locations for the database data for each, or use a more advanced technique.  
  
**Docker Compose file example with a volume for persistent storage**  
docker-compose.yml  
Saves the /var/lib/postgresql/data folder on the Docker container into the /container_volumes/pg folder on the host machine. 
```YAML
version: '3'
services:
  servoy:
    container_name: Servoy8
    image: 'itechpros/servoy:servoy_war_demo_dynamic_db'
    environment:
      - JAVA_XMS=128m
      - JAVA_XMX=1024m
    links:
      - db
    depends_on:
       - db
    ports:
      - '8080:8080'
  db:
    container_name: Postgres
    image: 'itechpros/servoy:servoy_war_demo_dynamic_db_pg'
    environment:
      - POSTGRES_DB=servoyworld_2017
      - POSTGRES_PASSWORD=demo
    volumes:
      - /container_volumes/pg:/var/lib/postgresql/data
```  
