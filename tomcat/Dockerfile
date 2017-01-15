FROM centos:7

MAINTAINER Scott Butler <scott@itechpros.com>

# Add RPM for windows fonts
ADD msttcore-fonts-2.0-3.noarch.rpm msttcore-fonts-2.0-3.noarch.rpm

# OS Updates and base installs that are useful.  net-tools is used by UserManager plugin
RUN yum update -y && \
yum install -y wget && \
yum install -y unzip && \
yum install -y tar && \
yum install -y net-tools && \

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
yum clean all

# Add custom config files TODO
#ADD tomcat.conf /usr/share/tomcat/conf/tomcat.conf
#ADD tomcat-users.xml /usr/share/tomcat/conf/tomcat-users.xml

# Define default working directory
WORKDIR /usr/share/tomcat/webapps

# Open Ports
EXPOSE 8080
EXPOSE 8443

CMD ["/opt/tomcat/tomcat.sh"]
