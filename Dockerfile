FROM codeception/codeception

MAINTAINER Flo Flo contact.magician@gmail.com

# Install docker and docker-compose
RUN apt-get update -y && apt-get install -y apt-transport-https ca-certificates \
        curl gnupg2 software-properties-common \
        && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
        && apt-key fingerprint 0EBFCD88 \
        && add-apt-repository \
              "deb [arch=amd64] https://download.docker.com/linux/debian \
              $(lsb_release -cs) \
              stable" \
        && apt-get update -y && apt-get install docker-ce docker-ce-cli containerd.io -y
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install Imagick
RUN apt-get update \
    && apt-get install -y libmagickwand-dev --no-install-recommends \
    && yes '' | pecl install -f imagick \
    && echo -e "\nextension=imagick.so" >> /usr/local/etc/php/php.ini