FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Shawn Bower <shawn.bower@gmail.com>

# Install.
RUN \
  apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    git \
    unzip \
    vim \
    wget \
    ruby \
    ruby-dev \
    clamav-daemon \
    openssh-client && \
  rm -rf /var/lib/apt/lists/*

RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/America/New_York /etc/localtime

#Clamav stuff
RUN freshclam -v && \
 mkdir /var/run/clamav && \
 chown clamav:clamav /var/run/clamav && \
 chmod 750 /var/run/clamav

COPY conf/clamd.conf /etc/clamav/clamd.conf

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc && \
  gem install json_pure -v 1.8.1 && \ 
  gem install puppet -v 3.7.5 && \
  gem install librarian-puppet -v 2.1.0 && \
  gem install hiera-eyaml -v 2.1.0

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
