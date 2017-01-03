FROM centos:7

MAINTAINER Scott Butler <scott@itechpros.com>

#bundle installer config
ADD servoy_install.xml servoy_install.xml

# OS Updates
RUN yum update -y && \
yum install -y wget && \
yum install -y unzip && \
yum install -y initscripts && \

# Install Java
wget --output-document jre.rpm --no-cookies --no-check-certificate \
  --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
   "http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jre-8u101-linux-x64.rpm" && \
yum localinstall -y jre.rpm && \
rm -f jre.rpm && \
yum clean all && \

# Install Servoy (also installs the service)
wget --output-document servoy_installer.jar --no-cookies --no-check-certificate "http://www.servoyguy.com/docker/download/servoy.php?version=6" && \
java -jar servoy_installer.jar servoy_install.xml && \
rm -f servoy_installer.jar && \
rm -f servoy_install.xml

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Open Ports
EXPOSE 8080

# Define default command.
CMD ["bash"]
