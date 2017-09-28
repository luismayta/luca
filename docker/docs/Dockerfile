FROM labpositiva/latex:3.6.1
MAINTAINER Luis Mayta <@slovacus>

COPY ./requirements/ /app/requirements/
COPY ./requirements.txt /app/requirements.txt

RUN apt-get update -y \
  && apt-get install -y build-essential

# set working directory to /app/
WORKDIR /app

# Install sphinx dependences
RUN pip install -r /app/requirements/docs.txt