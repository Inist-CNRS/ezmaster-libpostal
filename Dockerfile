FROM node:12
RUN apt-get update -y
RUN apt-get install -y curl libsnappy-dev autoconf automake libtool pkg-config sudo

RUN git clone https://github.com/openvenues/libpostal /src/libpostal
WORKDIR /src/libpostal
RUN ./bootstrap.sh \
	&& mkdir /data \
    && ./configure --prefix=/usr --datadir=/usr/share/libpostal 

RUN	make -j "$(nproc)" \
	&& make check

RUN make install \
	&& ldconfig \
	&& rm -rf /src
WORKDIR /app/local
COPY local/ /app/local
RUN npm install -g node-gyp \
    && npm install \
    && npm run build

# see https://github.com/Inist-CNRS/ezmaster
RUN echo '{ \
  "httpPort": 31976, \
  "configPath": "/app/config.json", \
  "dataPath": "/app/public" \
}' > /etc/ezmaster.json

WORKDIR /app
COPY package.json /app 
RUN npm install \
	&& npm cache clean --force
COPY config.json /app
COPY generate-dotenv.js /app
COPY docker-entrypoint.sh /app
RUN mkdir -p /app/public /sbin/.npm /sbin/.config \
	&& chown -R daemon:daemon /app /sbin/.npm /sbin/.config
COPY public/ /app/public

EXPOSE 31976
ENTRYPOINT [ "/app/docker-entrypoint.sh" ]
CMD [ "npm", "start" ]
