FROM ubuntu:20.04

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    wget \
    python3 \
    python3-pip \
    git \
    tzdata

# Set timezone to Etc/UTC
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && echo "Etc/UTC" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# Create symlink for Python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Create folder vendor
RUN mkdir -p /opt/vendor

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64
ENV HADOOP_VERSION=3.2.4
ENV HADOOP_HOME=/opt/vendor/hadoop-$HADOOP_VERSION
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Download and install Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -P /tmp \
    && tar -xzf /tmp/hadoop-$HADOOP_VERSION.tar.gz -C /opt/vendor \
    && rm /tmp/hadoop-$HADOOP_VERSION.tar.gz

# Copy configuration files

COPY . /opt/

# Ensure Python scripts are executable
RUN chmod +x /opt/mapper.py /opt/reducer.py

# Set working directory
WORKDIR /opt

# Start Hadoop services
CMD ["bash"]
