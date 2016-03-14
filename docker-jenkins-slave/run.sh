#!/bin/bash
HOSTPC="$(ifconfig | head -2 | awk '/inet/{print substr($2,1)}')-docker"
hostnamectl set-hostname $HOSTPC
java -jar /var/lib/jenkins/swarm-client-2.0-jar-with-dependencies.jar -master http://172.17.0.2:8080 -executors 2
