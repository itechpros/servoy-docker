#!/bin/sh

if [ -z "$CMD_LINE_START" ]; then
        CMD_LINE_START="java"
fi

while true
do
        $CMD_LINE_START -Djava.awt.headless=true -Xmx${JAVA_XMX} -Xms${JAVA_XMS} -XX:MaxPermSize=128m -XX:MetaspaceSize=200M -XX:MaxMetaspaceSize=200M -XX:MinMetaspaceFreeRatio=0 -XX:MaxMetaspaceFreeRatio=100 -classpath .:lib/activation.jar:lib/antlr.jar:lib/apache-mime4j.jar:lib/BrowserLauncher2.jar:lib/commons-codec.jar:lib/commons-collections.jar:lib/commons-dbcp.jar:lib/commons-fileupload.jar:lib/commons-io.jar:lib/commons-logging.jar:lib/commons-pool.jar:lib/dom4j.jar:lib/hibernate3.jar:lib/httpclient.jar:lib/httpclient-cache.jar:lib/httpcore.jar:lib/httpmime.jar:lib/j2db.jar:lib/j2dbdev.jar:lib/jabsorb.jar:lib/xstream.jar:lib/javassist.jar:lib/jcifs.jar:lib/joda-time.jar:lib/js.jar:lib/jta.jar:lib/jug.jar:lib/log4j.jar:lib/mail.jar:lib/MRJAdapter.jar:lib/networktnl.jar:lib/rmitnl.jar:lib/server-bootstrap.jar:lib/servlet-api.jar:lib/slf4j-api.jar:lib/slf4j-log4j.jar:lib/wicket.jar:lib/wicket-calendar.jar:lib/wicket-extentions.jar:lib/wiquery.jar:lib/fs-parser.jar:lib/fs-commons.jar:lib/minis.jar:lib/PBKDF2.jar com.servoy.j2db.server.main.ApplicationServer "$@"
        EXITCODE=$?
        if [ "$EXITCODE" != 99 ] && [ "x$EXITCODE" != "x$ADDITIONAL_RESTART_CODE" ]; then exit $EXITCODE; fi
done
