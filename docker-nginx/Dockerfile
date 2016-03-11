FROM centos

MAINTAINER Vlad Turbuleasa-Jurje <vlad.turbuleasa@gmail.com>

RUN rm -f /var/cache/yum/timedhosts.txt
RUN yum clean all
RUN yum install -y wget && yum install -y epel-release

# Install NGINX Plus
RUN yum install -y nginx.x86_64

RUN rm -rf /etc/nginx/conf.d/*; \
	mkdir -p /etc/nginx/ssl
# Download certificate and key from the customer portal (https://cs.nginx.com)
# and copy to the build context
ADD nginx-repo.crt /etc/nginx/ssl/
ADD nginx-repo.key /etc/nginx/ssl/
ADD default.conf /etc/nginx/conf.d/default.conf

# forward request logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

#CMD ["jenkins", "-g", "daemon off;"]
CMD ["nginx", "-g", "daemon off;"]
