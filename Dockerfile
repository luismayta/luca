FROM frolvlad/alpine-python2

RUN apk --update add \
  bash \
  cmake \
  gcc \
  make \
  g++ \
  zlib-dev

# Define working directory.
WORKDIR /docker/

# Install.
# RUN \
#   make install

# Define default command.
CMD ["bash"]
