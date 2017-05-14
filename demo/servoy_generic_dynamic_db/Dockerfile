FROM itechpros/servoy:servoy-oraclejava

MAINTAINER Scott Butler <scott@itechpros.com>

# Add my property file and my startup file
ADD servoy.properties $SERVOY_INSTALL_DIR/application_server/
ADD wait-for-postgres.sh $SERVOY_INSTALL_DIR/application_server/

RUN chmod +x $SERVOY_INSTALL_DIR/application_server/servoy_server_docker.sh
