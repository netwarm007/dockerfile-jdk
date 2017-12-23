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
    rm jdk-8u131-linux-x64.tar.gz

ENV PATH /opt/jdk1.8.0_131/bin:$PATH 
ENV JAVA_HOME /opt/jdk1.8.0_131

