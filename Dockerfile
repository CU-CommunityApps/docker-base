FROM ubuntu:14.04

# Install.
RUN \
  apt-get update && apt-get install -y \
    build-essential \ 
    curl \
    git \
    unzip \
    vim \ 
    wget \
    ruby \
    ruby-dev \
    clamav-daemon && \
  rm -rf /var/lib/apt/lists/* 
  
RUN rm /etc/localtime 
RUN ln -s /usr/share/zoneinfo/America/New_York /etc/localtime

#Clamav stuff
RUN freshclam -v
RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav
COPY conf/clamd.conf /etc/clamav/clamd.conf
      
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install puppet librarian-puppet

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
