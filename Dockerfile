FROM rcarmo/alpine-python:2.7
RUN apk --update add \
  bash \
  cmake \
  gcc \
  make \
  g++ \
  zlib-dev

ONBUILD COPY . /docker
ONBUILD RUN pip install -r /docker/requirements/dev.txt

# Define working directory.
WORKDIR /docker

EXPOSE 5000

# Define default command.
CMD gunicorn app:app -b :5000
