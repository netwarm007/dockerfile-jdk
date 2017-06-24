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

RUN hg clone http://hg.openjdk.java.net/jdk9/jdk9 openjdk9 && cd openjdk9 && sh ./get_source.sh

RUN wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
RUN tar zxvf jdk-8u131-linux-x64.tar.gz -C /opt

RUN cd openjdk9 && bash ./configure --with-cacerts-file=/etc/ssl/certs/java/cacerts --with-boot-jdk=/opt/jdk1.8.0_131 --disable-warnings-as-errors

RUN cd openjdk9 && make clean images

RUN cd openjdk9 && cp -a build/linux-x86_64-normal-server-release/images/jdk /opt/openjdk9

RUN find /opt/openjdk9 -type f -exec chmod a+r {} + && find /opt/openjdk9 -type d -exec chmod a+rx {} +

ENV PATH /opt/openjdk9/bin:$PATH 
ENV JAVA_HOME /opt/openjdk9

