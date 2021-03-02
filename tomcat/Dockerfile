FROM tomcat:9.0
RUN mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps.save
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
RUN rm /usr/local/tomcat/conf/tomcat-users.xml
ADD context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
ADD tomcat-users.xml /usr/local/tomcat/conf
