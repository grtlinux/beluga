#!/usr/bin/env bash
#
# 관리 노드에 Docker registry와 Mysql 패키지를 설치한다.
# mysql의 root계정 비번은 garuda123:) 이다.
# @author : Sang Wook, Song
#

sudo apt-get -y update

sudo wget -qO- https://get.docker.com/ | sh

sudo usermod -aG docker ubuntu

sudo docker run --name garuda-registry -d -p 5000:5000 registry

echo 'start on runlevel [2345]' | sudo tee /etc/init/docker-registry.conf
echo 'respawn' | sudo tee -a /etc/init/docker-registry.conf
echo 'kill timeout 20' | sudo tee -a /etc/init/docker-registry.conf
echo 'exec docker start garuda-registry' | sudo tee -a /etc/init/docker-registry.conf

echo "mysql-server-5.6 mysql-server/root_password password garuda123:)" | sudo debconf-set-selections
echo "mysql-server-5.6 mysql-server/root_password_again password garuda123:)" | sudo debconf-set-selections

sudo apt-get install mysql-server-5.6 -y

sudo sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf

mysql -uroot -p'garuda123:)' -e 'USE mysql; UPDATE `user` SET `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

sudo service mysql restart