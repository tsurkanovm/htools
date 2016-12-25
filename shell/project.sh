#!/bin/sh
Project_home=/var/www/htools
echo "cd $Project_home" >> ~/.bashrc

cd $Project_home

#composer
COMPOSER_PROCESS_TIMEOUT=2000 composer install
#docs
cd $Project_home/docs/
make html
cd $Project_home/app/Resources/docs/
make html
