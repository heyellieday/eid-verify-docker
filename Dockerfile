FROM ubuntu:18.04

RUN apt-get update && apt-get -y install cmake libssl1.0-dev xsdcxx libxml-security-c-dev  zlib1g-dev

RUN apt-get -y install git

RUN git clone --recursive https://github.com/open-eid/libdigidocpp && cd libdigidocpp

RUN apt-get -y install xxd

RUN cd libdigidocpp && mkdir build && cd build && cmake ..

RUN cd libdigidocpp/build && make

RUN cd libdigidocpp/build && make install

RUN ldconfig

RUN apt-get -y install curl

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh


RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

# nvm environment variables
ENV NVM_DIR "/root/.nvm"
ENV NODE_VERSION 10.15.0

RUN echo $HOME
# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# RUN npm install
# If you are building your code for production
RUN npm install

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "node", "server.js" ]