FROM ubuntu:trusty-20180302
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# These three commands are used to fix dpkg package.
# dpkg has the following bug.
# https://bugs.launchpad.net/ubuntu/+source/dpkg/+bug/1730627
RUN apt-get clean
RUN apt-get update
RUN apt-get install dpkg

RUN apt-get install -y -q software-properties-common wget
# RUN add-apt-repository -y ppa:mozillateam/firefox-next

# Install Node 12
RUN wget -qO- https://deb.nodesource.com/setup_12.x | sudo bash -
RUN sudo apt-get install -y nodejs

# Install browsers
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update -y
RUN apt-get install -y -q \
    # ubuntu-restricted-extras \
    # firefox \
    google-chrome-beta

# Install JS app
WORKDIR /opt/app
COPY package.json /opt/app/

ENV PATH="/opt/app/node_modules/.bin:${PATH}"
ENV TEST_ENV="ci"
