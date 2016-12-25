FROM cristo/symfony3
MAINTAINER Olexander Kutsenko <olexander.kutsenko@gmail.com>

#Copy shells 
COPY shell/nginx.sh /root/nginx.sh
COPY shell/xdebug.sh /root/xdebug.sh
COPY shell/project.sh /root/project.sh
RUN chmod +x /root/*.sh

#Install packets
RUN apt-get install npm nodejs-legacy python-sphinx -y

#Install capifony
RUN apt-get install ruby2.0 -y
RUN gem install capifony

#Copy code to docker container and set up project
COPY htools /var/www/htools
RUN chmod -R www-data:www-data /var/www
RUN /root/nginx.sh
RUN /root/xdebug.sh
RUN /root/project.sh

EXPOSE 80 22 8080
