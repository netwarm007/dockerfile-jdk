FROM tim03/gcc

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	libxt-dev \
	zip \
        unzip \
	file \
	libelf-dev \
	libx11-dev \
	libxext-dev libxrender-dev libxtst-dev libasound2-dev libcups2-dev libfreetype6-dev ca-certificates-java && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

RUN wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz && \
    tar zxvf jdk-8u131-linux-x64.tar.gz -C /opt && \
    hg clone http://hg.openjdk.java.net/jdk8/jdk8 openjdk8 && cd openjdk8 && sh ./get_source.sh && \
    bash ./configure --with-cacerts-file=/etc/ssl/certs/java/cacerts --with-boot-jdk=/opt/jdk1.8.0_131 && \
    make clean images && \
    cp -a build/linux-x86_64-normal-server-release/images/jdk /opt/openjdk8 && \
    find /opt/openjdk8 -type f -exec chmod a+r {} + && find /opt/openjdk8 -type d -exec chmod a+rx {} + && \
    rm -rf /usr/src/* /opt/jdk1.8.0_131

ENV PATH /opt/openjdk8/bin:$PATH 
ENV JAVA_HOME /opt/openjdk8

