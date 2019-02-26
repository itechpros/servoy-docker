FROM itechpros/servoy:tomcat-oraclejava

ENV S3_BUCKET ""
ENV S3_PATH ""

ADD s3_copy.sh $CATALINA_HOME/

RUN yum install -y awscli && \
    chmod +x $CATALINA_HOME/s3_copy.sh

CMD $CATALINA_HOME/s3_copy.sh