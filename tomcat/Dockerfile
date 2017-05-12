FROM store/oracle/serverjre:8

MAINTAINER Scott Butler <scott@itechpros.com>

# Environment variables
ENV JAVA_HOME /usr/java/latest
ENV CATALINA_HOME /usr/share/tomcat
ENV TOMCAT_USERNAME ${TOMCAT_USERNAME:-tomcatAdmin}
ENV TOMCAT_PASSWORD ${TOMCAT_PASSWORD:-tomcatPassword!}
ENV TOMCAT_MAX_FILE_SIZE ${TOMCAT_MAX_FILE_SIZE:-300000000}
ENV JAVA_XMS ${JAVA_XMS:-128m}
ENV JAVA_XMX ${JAVA_XMX:-1024m}
ENV SERVOY_USER_HOME ${SERVOY_USER_HOME:-/home/servoy}

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

# Add Tomcat
mkdir /usr/share/tomcat && \
wget -O /usr/share/tomcat/apache-tomcat.tar.gz http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz && \
tar -zxvf /usr/share/tomcat/apache-tomcat.tar.gz -C /usr/share/tomcat --strip-components=1

# Add custom config files
ADD tomcat.conf /usr/share/tomcat/conf
ADD manager.xml /usr/share/tomcat/conf/Catalina/localhost
ADD tomcat-users.xml /usr/share/tomcat/conf
ADD web.xml /usr/share/tomcat/webapps/manager/WEB-INF
ADD tomcat_start.sh /usr/share/tomcat

# Make the startup executable
RUN chmod +x /usr/share/tomcat/tomcat_start.sh

# Define default working directory
WORKDIR /usr/share/tomcat/webapps

# Open Ports
EXPOSE 8080
EXPOSE 8443

# Substitute Environment variables in the config files and start services within the custom script
CMD /usr/share/tomcat/tomcat_start.sh
