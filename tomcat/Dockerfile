FROM store/oracle/serverjre:8

MAINTAINER Scott Butler <scott@itechpros.com>

# Environment variables
ENV CATALINA_HOME /usr/share/tomcat
ENV SERVOY_USER_HOME ${SERVOY_USER_HOME:-/home/servoy}
ENV TOMCAT_VERSION_MAJOR ${TOMCAT_VERSION_MAJOR:-8}
ENV TOMCAT_VERSION_FULL ${TOMCAT_VERSION_FULL:-8.5.15}
ENV TOMCAT_USERNAME ${TOMCAT_USERNAME:-tomcatAdmin}
ENV TOMCAT_PASSWORD ${TOMCAT_PASSWORD:-tomcatPassword!}
ENV TOMCAT_MAX_FILE_SIZE ${TOMCAT_MAX_FILE_SIZE:-300000000}
ENV JAVA_XMS ${JAVA_XMS:-128m}
ENV JAVA_XMX ${JAVA_XMX:-1024m}
ENV CATALINA_OPTS -Xms${JAVA_XMS} -Xmx${JAVA_XMX} -DSERVOY_USER_HOME=${SERVOY_USER_HOME}

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

# Create Servoy Home Dir and make sure we have full access
mkdir -p $SERVOY_USER_HOME && \
chmod +rwx $SERVOY_USER_HOME && \

# Add Tomcat
mkdir $CATALINA_HOME && \
wget -O $CATALINA_HOME/apache-tomcat.tar.gz http://www-us.apache.org/dist/tomcat/tomcat-$TOMCAT_VERSION_MAJOR/v$TOMCAT_VERSION_FULL/bin/apache-tomcat-$TOMCAT_VERSION_FULL.tar.gz && \
tar -zxvf $CATALINA_HOME/apache-tomcat.tar.gz -C $CATALINA_HOME --strip-components=1

# Add custom config files
ADD tomcat.conf $CATALINA_HOME/conf/
ADD manager.xml $CATALINA_HOME/conf/Catalina/localhost/
ADD tomcat-users.xml $CATALINA_HOME/conf/
ADD web.xml $CATALINA_HOME/webapps/manager/WEB-INF/
ADD tomcat_start.sh $CATALINA_HOME/

# Make the startup executable
RUN chmod +x $CATALINA_HOME/tomcat_start.sh

# Define default working directory
WORKDIR $CATALINA_HOME/webapps

# Open Ports
EXPOSE 8080
EXPOSE 8443

# Substitute Environment variables in the config files and start services within the custom script
CMD $CATALINA_HOME/tomcat_start.sh
