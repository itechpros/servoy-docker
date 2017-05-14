FROM itechpros/servoy:servoy-oraclejava

MAINTAINER Scott Butler <scott@itechpros.com>

# Add my property file and my startup file
ADD servoy.properties $SERVOY_INSTALL_DIR/application_server/
ADD servoy_docker.sh $SERVOY_INSTALL_DIR/application_server/

# Set permissions
RUN chmod +x $SERVOY_INSTALL_DIR/application_server/servoy_docker.sh

# Define default command.
CMD ["./servoy_docker.sh"]
