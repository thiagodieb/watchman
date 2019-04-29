FROM node:8-alpine

RUN apk add --no-cache git build-base automake autoconf linux-headers

RUN git clone https://github.com/facebook/watchman.git /tmp/watchman-src && \
  cd /tmp/watchman-src && \
  git checkout v4.7.0

RUN cd /tmp/watchman-src && \
    ls -la autogen.sh && \
    ./autogen.sh

RUN cd /tmp/watchman-src && \
    ./configure --enable-statedir=/tmp --without-python --without-pcre --enable-lenient

RUN cd /tmp/watchman-src && \
    make && \
    make install

# RUN mkdir /opt/watchman/

# WORKDIR /opt/watchman/
# # Copy the watchman executable binary directly from our image:
# COPY --from=icalialabs/watchman:4-alpine3.4 /usr/local/bin/watchman* /usr/local/bin/



# FROM node:8-alpine
# LABEL maintainer "Ash Wilson"

# RUN apk add --no-cache git build-base automake autoconf linux-headers && \
#   git clone https://github.com/facebook/watchman.git /tmp/watchman-src && \
#   cd /tmp/watchman-src && \
#   git checkout v4.7.0 && \
#   ./autogen.sh && \
#   ./configure --enable-statedir=/tmp --without-python --without-pcre && \
#   make && \
#   make install && \
#   apk del git build-base automake autoconf linux-headers && \
#   rm -r /tmp/watchman-src