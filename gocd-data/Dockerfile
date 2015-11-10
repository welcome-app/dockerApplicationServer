FROM busybox

COPY conf/cruise-config.xml /etc/go/cruise-config.xml
COPY home/ssh /var/go/.ssh
COPY home/ssh /root/.ssh
COPY home/docker /root/.docker
COPY home/tutum /root/.tutum


RUN chown -R 999:999 /etc/go /var/go

CMD tail -f /etc/go/cruise-config.xml
VOLUME ["/etc/go/"]
VOLUME ["/var/go/.ssh"]
VOLUME ["/root/.ssh"]
VOLUME ["/root/.docker"]
VOLUME ["/root/.tutum"]