FROM store/oracle/serverjre:8

MAINTAINER Scott Butler <scott@itechpros.com>

# Environment variables
ENV SERVOY_VERSION_MAJOR ${SERVOY_VERSION_MAJOR:-8}
ENV SERVOY_INSTALL_DIR ${SERVOY_INSTALL_DIR:-/usr/home/servoy}
ENV JAVA_XMS ${JAVA_XMS:-128m}
ENV JAVA_XMX ${JAVA_XMX:-1024m}

# Bundle installer config
ADD servoy_install_$SERVOY_VERSION_MAJOR.xml servoy_install.xml
ADD servoy_docker.sh $SERVOY_INSTALL_DIR/application_server/
ADD servoy_server_docker.sh $SERVOY_INSTALL_DIR/application_server/

# Add RPM for windows fonts
ADD msttcore-fonts-2.0-3.noarch.rpm msttcore-fonts-2.0-3.noarch.rpm

# OS Updates and base installs that are useful.  net-tools is used by UserManager plugin
RUN yum update -y && \
yum install -y \
  wget \
  unzip \
  tar \
  gzip \
  gunzip \
  net-tools \
  gettext && \
  
# Install envplate templating engine for environment variable substitution
curl -sLo /usr/local/bin/ep https://github.com/kreuzwerker/envplate/releases/download/v0.0.8/ep-linux  && \
chmod +x /usr/local/bin/ep && \

# Install Windows fonts, like Arial and Verdana
rpm -Uvh msttcore-fonts-2.0-3.noarch.rpm && \

# Cleanup
yum clean all && \

# Install Servoy 
wget --output-document servoy_installer.jar --no-cookies --no-check-certificate "http://www.servoyguy.com/docker/download/servoy.php?version=$SERVOY_VERSION_MAJOR" && \
java -jar servoy_installer.jar servoy_install.xml && \
rm -f servoy_installer.jar && \
rm -f servoy_install.xml && \

#set permissions
chmod +x $SERVOY_INSTALL_DIR/application_server/servoy_docker.sh
chmod +x $SERVOY_INSTALL_DIR/application_server/servoy_server_docker.sh

# Set environment variables.
ENV HOME $SERVOY_INSTALL_DIR/

# Define working directory.
WORKDIR $SERVOY_INSTALL_DIR/application_server

# Open Ports
EXPOSE 8080
EXPOSE 1099

# Define default command.
CMD ["./servoy_docker.sh"]
