FROM itechpros/servoy:tomcat-oraclejava

ENV S3_BUCKET ""
ENV S3_PATH ""

RUN yum install -y awscli

ADD s3_copy.sh $CATALINA_HOME/

CMD $CATALINA_HOME/s3_copy.sh