#!/bin/sh

echo "Running Servoy Start Script"
echo "Filling templates with environmental variables"
ep /usr/share/tomcat/conf/tomcat.conf
ep /usr/share/tomcat/conf/tomcat-users.xml
ep /usr/share/tomcat/webapps/manager/WEB-INF/web.xml

echo "Starting Tomcat"
/usr/share/tomcat/bin/catalina.sh run
