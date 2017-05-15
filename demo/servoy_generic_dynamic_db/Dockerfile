FROM itechpros/servoy:servoy-oraclejava

MAINTAINER Scott Butler <scott@itechpros.com>

# Add my property file and my startup file
ADD servoy.properties $SERVOY_INSTALL_DIR/application_server/
ADD wait-for-postgres.sh $SERVOY_INSTALL_DIR/application_server/

# Add Postgres Client 9.6 and special script to wait for postgres to startup
RUN wget -O pgyum.rpm https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm && \
yum localinstall -y pgyum.rpm && \
yum install -y postgresql96 && \
chmod +x $SERVOY_INSTALL_DIR/application_server/wait-for-postgres.sh

# Add our postgres path to path so our wait-for-postgres.sh works
ENV PATH="${PATH}:/usr/pgsql-9.6/bin"
