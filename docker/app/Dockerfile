FROM python:3.6.0

MAINTAINER Luis Mayta <@slovacus>

COPY ./requirements/ /usr/src/requirements/
COPY ./requirements.txt /usr/src/requirements.txt

# set working directory to /app/
WORKDIR /usr/src

# install python dependencies
RUN pip install -r /usr/src/requirements/dev.txt
