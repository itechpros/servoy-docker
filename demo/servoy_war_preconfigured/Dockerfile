FROM itechpros/servoy:tomcat-oraclejava

MAINTAINER Scott Butler <scott@itechpros.com>

ENV WAR_CONTEXT ${WAR_CONTEXT:-servoy}

# Add my war file
RUN wget -O $CATALINA_HOME/webapps/$WAR_CONTEXT.war http://servoyguy.com/docker/demo/servoy8_samplecrm.war && \

# Define default command.
CMD ["./servoy_docker.sh"]
