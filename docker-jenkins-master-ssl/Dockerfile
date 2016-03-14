FROM centos:centos7

MAINTAINER Vlad Turbuleasa <vlad.turbuleasa@gmail.com>

# Clean yum cache so that fastmirror works
RUN rm -f /var/cache/yum/x86_64/7/timedhosts.txt

#Tools:
RUN \
  yum update -y && \
  yum install -y wget initscripts epel-release net-tools &&\
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
	yum -y install jenkins git

#Installing plugins on jenkins
RUN mkdir -p /var/lib/jenkins/plugins/; \
	wget -nv -O /var/lib/jenkins/plugins/scm-api.hpi https://updates.jenkins-ci.org/download/plugins/scm-api/latest/scm-api.hpi; \
	wget -nv -O /var/lib/jenkins/plugins/git-client.hpi https://updates.jenkins-ci.org/download/plugins/git-client/1.11.1/git-client.hpi; \
	wget -nv -O /var/lib/jenkins/plugins/git.hpi https://updates.jenkins-ci.org/download/plugins/git/2.3/git.hpi; \
	wget -nv -O /var/lib/jenkins/plugins/ws-cleanup.hpi https://updates.jenkins-ci.org/download/plugins/ws-cleanup/0.24/ws-cleanup.hpi; \
	wget -nv -O /var/lib/jenkins/plugins/token-macro.hpi https://updates.jenkins-ci.org/download/plugins/token-macro/1.10/token-macro.hpi; \
	wget -nv -O /var/lib/jenkins/plugins/config-file-provider.hpi http://mirrors.xmission.com/hudson/plugins/config-file-provider/2.7.5/config-file-provider.hpi; \
	wget -nv -O /var/lib/jenkins/plugins/swarm.hpi https://updates.jenkins-ci.org/latest/swarm.hpi; \
	wget -nv -O /var/lib/jenkins/plugins/gradle.hpi https://updates.jenkins-ci.org/latest/gradle.hpi; \
	chown -R jenkins:jenkins /var/lib/jenkins/plugins

RUN easy_install supervisor

ADD supervisord.conf /etc/

# make supervisor run in foreground
RUN sed -i -e "s/^nodaemon=false/nodaemon=true/" /etc/supervisord.conf


EXPOSE 443 80 8080

CMD ["/usr/bin/supervisord", "-c" , "/etc/supervisord.conf" ]
