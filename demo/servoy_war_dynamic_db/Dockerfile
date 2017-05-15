FROM itechpros/servoy:tomcat-oraclejava

MAINTAINER Scott Butler <scott@itechpros.com>

ENV WAR_CONTEXT ${WAR_CONTEXT:-servoy}

ADD wait-for-postgres.sh $CATALINA_HOME/

# Add Postgres Client 9.6 and special script to wait for postgres to startup
RUN wget -O pgyum.rpm https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm && \
yum localinstall -y pgyum.rpm && \
yum install -y postgresql96 && \
chmod +x $CATALINA_HOME/wait-for-postgres.sh && \

# Add my war file
wget -O $CATALINA_HOME/webapps/$WAR_CONTEXT.war http://servoyguy.com/docker/demo/svySampleCRM_dockerCompose.war

# Define an Entrypoint, Runs before the command
ENTRYPOINT ["$CATALINA_HOME/wait-for-postgres.sh", "db", "5432"]

# Define default command.
CMD ["$CATALINA_HOME/tomcat_start.sh"]
