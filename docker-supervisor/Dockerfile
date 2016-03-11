FROM centos:centos7

MAINTAINER Vlad Turbuleasa <vlad.turbuleasa@gmail.com>

# Clean yum cache so that fastmirror works
RUN rm -f /var/cache/yum/timedhosts.txt

#Tools:
RUN \
  yum update -y && \
  yum install -y wget initscripts epel-release &&\
  yum install -y java-1.8.0-openjdk.x86_64 python-setuptools hostname inotify-tools yum-utils which && \
  yum clean all 


#Nginx:
RUN yum install -y nginx.x86_64;\
	rm -rf /etc/nginx/conf.d/*; \
	mkdir -p /etc/nginx/ssl; 

ADD nginx-repo.crt /etc/nginx/ssl/
ADD nginx-repo.key /etc/nginx/ssl/
ADD default.conf /etc/nginx/conf.d/
ADD nginx.conf /etc/nginx/

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

#Jenkins:
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo; \
	rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key; \
	yum -y install jenkins
RUN easy_install supervisor

ADD supervisord.conf /etc/

# make supervisor run in foreground
RUN sed -i -e "s/^nodaemon=false/nodaemon=true/" /etc/supervisord.conf


EXPOSE 443 80 8080

CMD ["/usr/bin/supervisord", "-c" , "/etc/supervisord.conf" ]
