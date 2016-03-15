## Docker CI Environment components 

This is Dockerfiles are opensource and anyone can contribute!

**docker-jenkins**
- Simple Jenkins install , clean and easy.
- open-jdk on it , no maven/gradle tools , could be installed from jenkins UI.

**docker-jenkins-master-ssl**
- If you want a cluster of jenins + some other slaves , start the Jenkins master first.
- Jenkins
- Nginx as a SSL proxy
- Maven and gradle
- Oracle JDK 1.8
- Git,gradle,maven,swarm and other needed plugins 

**docker-jenkins-slave**
- Swarm plugin
- Maven and Gradle
- Oracle JDK
- Git plugin

**docker-nginx**
- Simple Nginx dockerfile

If you need help please put a note/issue and I will try to help.
All files we're tested and built with docker version: 1.10.2 , build c3959b1 on CentOS 7.
NOTE: Please take care about IPv6 , disable it as a simple recomandation.
