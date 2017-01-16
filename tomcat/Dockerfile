FROM itechpros/servoy:centos7-systemd

MAINTAINER Scott Butler <scott@itechpros.com>

# Environment variables
ENV JAVA_HOME /usr/java/latest
ENV CATALINA_HOME /usr/share/tomcat
ENV TOMCAT_USERNAME ${TOMCAT_USERNAME:-tomcatAdmin}
ENV TOMCAT_PASSWORD ${TOMCAT_PASSWORD:-tomcatPassword!}
ENV JAVA_XMS ${JAVA_XMS:-128}
ENV JAVA_XMX ${JAVA_XMX:-1024}

# Add RPM for windows fonts
ADD msttcore-fonts-2.0-3.noarch.rpm msttcore-fonts-2.0-3.noarch.rpm

# OS Updates and base installs that are useful.  net-tools is used by UserManager plugin
RUN yum update -y && \
yum install -y wget && \
yum install -y unzip && \
yum install -y tar && \
yum install -y net-tools && \
yum install -y gettext && \

#Install Windows fonts, like Arial and Verdana
rpm -Uvh msttcore-fonts-2.0-3.noarch.rpm && \

# Install Java
wget --output-document jre.rpm --no-cookies --no-check-certificate \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
   "http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jre-8u101-linux-x64.rpm" && \
yum localinstall -y jre.rpm && \
rm -f jre.rpm && \

# Install Tomcat and tomcat web admin interface
yum install -y tomcat && \
yum install -y tomcat-webapps tomcat-admin-webapps && \

# Cleanup
yum clean all && \

# Enable the service
systemctl enable tomcat

# Add custom config files
ADD tomcat.conf /usr/share/tomcat/conf
ADD tomcat-users.xml /usr/share/tomcat/conf

# Define default working directory
WORKDIR /usr/share/tomcat/webapps

# Open Ports
EXPOSE 8080
EXPOSE 8443

# Substitute Environment variables in the config files and start services.
CMD envsubst < /usr/share/tomcat/conf/tomcat.conf | tee /usr/share/tomcat/conf/tomcat.conf && \
envsubst < /usr/share/tomcat/conf/tomcat-users.xml | tee /usr/share/tomcat/conf/tomcat-users.xml && \
exec /usr/sbin/init
