FROM ubuntu

ENV APACHE_ANT_VERSION 1.8.4
ENV GRADLE_2_3_VERSION 2.3
ENV GRADLE_2_4_VERSION 2.4
ENV GRADLE_2_5_VERSION 2.5
ENV MAVEN_3_3_VERSION 3.3.3
ENV MAVEN_3_2_VERSION 3.2.1

RUN mkdir -p \
	/tmp/build \
	/opt 
	
RUN echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

RUN apt-get -y install software-properties-common \
      && add-apt-repository -y ppa:webupd8team/java \
      && apt-get -y update \
      && apt-get -y install \
			wget \
			curl \
			unzip \
			python \
			git \
			node.js \
			openjdk-6-jdk \
			openjdk-7-jdk \
			oracle-java6-installer \
			oracle-java7-installer \
			oracle-java8-installer	

RUN update-java-alternatives -s java-8-oracle

RUN ln -s /usr/lib/jvm/java-6-oracle /opt/jdk-6
RUN ln -s /usr/lib/jvm/java-7-oracle /opt/jdk-7
RUN ln -s /usr/lib/jvm/java-8-oracle /opt/jdk-8
RUN ln -s /usr/lib/jvm/java-1.6.0-openjdk-amd64 /opt/open-jdk-6
RUN ln -s /usr/lib/jvm/java-1.7.0-openjdk-amd64 /opt/open-jdk-7

RUN wget http://archive.apache.org/dist/ant/binaries/apache-ant-${APACHE_ANT_VERSION}-bin.tar.gz -O /tmp/build/apache-ant-${APACHE_ANT_VERSION}-bin.tgz && tar -xzf /tmp/build/apache-ant-${APACHE_ANT_VERSION}-bin.tgz -C /opt && ln -s /opt/apache-ant-${APACHE_ANT_VERSION} /opt/ant-1.8

RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_2_3_VERSION}-bin.zip -O /tmp/build/gradle-${GRADLE_2_3_VERSION}-bin.zip && unzip -d /opt/ /tmp/build/gradle-${GRADLE_2_3_VERSION}-bin.zip

RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_2_4_VERSION}-bin.zip -O /tmp/build/gradle-${GRADLE_2_4_VERSION}-bin.zip && unzip -d /opt/ /tmp/build/gradle-${GRADLE_2_4_VERSION}-bin.zip

RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_2_5_VERSION}-bin.zip -O /tmp/build/gradle-${GRADLE_2_5_VERSION}-bin.zip && unzip -d /opt/ /tmp/build/gradle-${GRADLE_2_5_VERSION}-bin.zip

RUN wget http://apache.mirror.gtcomm.net/maven/maven-3/${MAVEN_3_3_VERSION}/binaries/apache-maven-${MAVEN_3_3_VERSION}-bin.tar.gz -O /tmp/build/maven-${MAVEN_3_3_VERSION}-bin.tar.gz && mkdir -p /opt/maven-${MAVEN_3_3_VERSION} && tar -xzf /tmp/build/maven-${MAVEN_3_3_VERSION}-bin.tar.gz -C /opt && ln -s /opt/maven-${MAVEN_3_3_VERSION} /opt/maven-3.3

RUN wget http://archive.apache.org/dist/maven/maven-3/${MAVEN_3_2_VERSION}/binaries/apache-maven-${MAVEN_3_2_VERSION}-bin.tar.gz -O /tmp/build/maven-${MAVEN_3_2_VERSION}-bin.tar.gz && mkdir -p /opt/maven-${MAVEN_3_3_VERSION} && tar -xzf /tmp/build/maven-${MAVEN_3_2_VERSION}-bin.tar.gz -C /opt && ln -s /opt/maven-${MAVEN_3_2_VERSION} /opt/maven-3.2

RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o /tmp/build/awscli-bundle.zip && unzip -d /tmp/build /tmp/build/awscli-bundle.zip && sudo /tmp/build/awscli-bundle/install -i /usr/local/bin/aws

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*