FROM tim03/clang
WORKDIR /usr/src

RUN wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz && \
    tar zxvf jdk-8u131-linux-x64.tar.gz -C /opt && \
    rm jdk-8u131-linux-x64.tar.gz

ENV PATH /opt/jdk1.8.0_131/bin:$PATH 
ENV JAVA_HOME /opt/jdk1.8.0_131

