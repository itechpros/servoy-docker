FROM itechpros/servoy:tomcat-oraclejava

MAINTAINER Scott Butler <scott@itechpros.com>

ENV WAR_CONTEXT ${WAR_CONTEXT:-servoy}

ADD wait-for-postgres.sh $SERVOY_INSTALL_DIR/application_server/

# Add Postgres Client 9.6 and special script to wait for postgres to startup
RUN wget -O pgyum.rpm https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm && \
yum localinstall -y pgyum.rpm && \
yum install -y postgresql96 && \
chmod +x $SERVOY_INSTALL_DIR/application_server/wait-for-postgres.sh && \

# Add my war file
RUN wget -O $CATALINA_HOME/webapps/$WAR_CONTEXT.war http://servoyguy.com/docker/demo/servoy8_samplecrm.war && \

# Define an Entrypoint, Runs before the command
ENTRYPOINT ["./wait-for-postgres.sh", "db", "5432"]

# Define default command.
CMD ["$CATALINA_HOME/tomcat_start.sh"]
