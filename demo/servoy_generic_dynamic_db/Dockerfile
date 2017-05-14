FROM itechpros/servoy:servoy-oraclejava

MAINTAINER Scott Butler <scott@itechpros.com>

# Add my property file and my startup file
ADD servoy.properties $SERVOY_INSTALL_DIR/application_server/

# Define default command.
CMD ["./servoy_docker.sh"]
