FROM openshift/jenkins-slave-base-centos7
MAINTAINER Oliver Weise <oliver.weise@consol.de>
LABEL io.k8s.description="Jenkins slave image for Maven-built JavaScript Apps (AngularJS for example) also using NPM in the build process" \
      io.k8s.display.name="Maven && npm builder jenkins slave" \
      io.openshift.tags="builder,js"
RUN yum install -y epel-release
RUN yum install -y yum-utils && \
    yum install -y wget && \
    yum install -y java-1.8.0-openjdk-devel && \
    yum install -y bzip2 && \
    yum makecache fast
RUN wget http://mirror.dkd.de/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz && \
    su -c "tar -zxvf apache-maven-3.5.0-bin.tar.gz -C /usr/local"  && \
    ln -s /usr/local/apache-maven-3.5.0/bin/mvn /usr/local/bin/mvn && \
    ln -s /usr/local/apache-maven-3.5.0/bin/mvn /usr/local/bin/maven
RUN curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - && \
    yum -y install nodejs
RUN yum remove docker \
      docker-common \
      container-selinux \
      docker-selinux \
      docker-engine \
      docker-ce && \
    yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo && \
    yum makecache fast && \
    yum install -y docker-ce && \
    systemctl enable docker
ENV NODE_ENV=development
ENV M2_HOME=/usr/local/apache-maven-3.5.0
ENV MAVEN_VERSION=3.5.0
ENV JAVA_HOME=/usr/lib/jvm/java-openjdk
RUN chmod -R a+rwx /var/log
RUN chmod -R a+rwx /run
USER 1001
WORKDIR /home/jenkins/
CMD ["usage"]


