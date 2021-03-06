#!/bin/sh

mkdir -p /var/www/htools
Project_home=/var/www/htools
Project_name=htools





echo "server {
	  listen *:8080;
          root $Project_home/web;

          client_max_body_size 40m;

          location / {
              try_files \$uri /app.php\$is_args\$args;
          }

          location ~ ^/(app|app_dev|config)\.php(/|$) {
              fastcgi_pass unix:/var/run/php5-fpm.sock;
              fastcgi_split_path_info ^(.+\.php)(/.*)$;
              include fastcgi_params;
              fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
              fastcgi_param HTTPS off;
              fastcgi_read_timeout 600;
              fastcgi_buffers 64 64k;
              fastcgi_buffer_size 128k;
          }

          error_log /var/log/nginx/$Project_name.error.log;
          access_log /var/log/nginx/$Project_name.access.log;
      }" >> /etc/nginx/sites-available/project

ln -s /etc/nginx/sites-available/$Project_name /etc/nginx/sites-enabled/
rm /etc/nginx/sites-available/default

service nginx restart
service php7-fpm restart
