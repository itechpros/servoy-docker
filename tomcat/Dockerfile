# Start with AlpineLinux with a glibc-2.23 and Oracle Java 8
FROM itechpros/servoy:tomcat-alpine

MAINTAINER Scott Butler <scott@itechpros.com>

# Environment variables
ENV TOMCAT_USERNAME ${TOMCAT_USERNAME:-tomcatAdmin}
ENV TOMCAT_PASSWORD ${TOMCAT_PASSWORD:-tomcatPassword!}
ENV TOMCAT_MAX_FILE_SIZE ${TOMCAT_MAX_FILE_SIZE:-300000000}
ENV JAVA_XMS ${JAVA_XMS:-128m}
ENV JAVA_XMX ${JAVA_XMX:-1024m}

# Updates
RUN apk add --update \
      ca-certificates \
      curl \
      wget \
  && rm -rf /var/cache/apk/*

# Install envplate templating engine for environment variable substitution
curl -sLo /usr/local/bin/ep https://github.com/kreuzwerker/envplate/releases/download/v0.0.8/ep-linux  && \
chmod +x /usr/local/bin/ep && \

# Add custom config files
ADD tomcat.conf /usr/local/tomcat/conf
ADD tomcat-users.xml /usr/local/tomcat/conf
ADD web.xml /usr/local/tomcat/webapps/manager/WEB-INF/web.xml

# Define default working directory
WORKDIR /usr/share/tomcat/webapps

# Open Ports
EXPOSE 8080
EXPOSE 8443

# Substitute Environment variables in the config files and start services.
CMD ep /usr/local/tomcat/conf/tomcat.conf && \
ep /usr/local/tomcat/conf/tomcat-users.xml && \
ep /usr/local/tomcat/webapps/manager/WEB-INF/web.xml && \
exec catalina.sh
