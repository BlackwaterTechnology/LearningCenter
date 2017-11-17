FROM centos
MAINTAINER wangyijie
COPY maxscale-2.1.5-1.rhel.7.x86_64.rpm .
RUN yum install -y maxscale-2.1.5-1.rhel.7.x86_64.rpm; \
    rm -f maxscale-2.1.5-1.rhel.7.x86_64.rpm; \
    yum install -y vim net-tools iproute telnet; \
    yum  clean all
COPY maxscale.cnf /etc/
EXPOSE 3306
CMD maxscale -f /etc/maxscale.cnf  -l stdout
