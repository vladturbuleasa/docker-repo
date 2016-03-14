FROM centos:centos7
MAINTAINER Vlad Turbuleasa <vlad.turbuleasa@gmail.com>

# Clean yum cache so that fastmirror works
#RUN rm -f /var/cache/yum/timedhosts.txt

# Update all
RUN yum clean all && yum -y update

RUN yum -y install \
	epel-release \
	java-1.8.0-openjdk.x86_64 \
	wget \
	zip \
	unzip \
	mc \
	net-tools \
	vim

RUN yum -y install git
RUN echo $(grep $(hostname) /etc/hosts | cut -f1) $(ifconfig | head -2 | awk '/inet/{print substr($2,1)}')'-docker' >> /etc/hosts
RUN echo 'Installing JenkinsSlave...';
RUN mkdir -p /var/lib/jenkins;
RUN touch /var/lib/jenkins/jenkins.log;
RUN wget -nv -O /var/lib/jenkins/swarm-client-2.0-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/2.0/swarm-client-2.0-jar-with-dependencies.jar;
		

EXPOSE 50000

ADD run.sh /var/lib/jenkins/run.sh

RUN chmod +x /var/lib/jenkins/run.sh

CMD /var/lib/jenkins/run.sh 
