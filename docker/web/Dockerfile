FROM python:2.7.9
MAINTAINER Luis Mayta <@slovacus>

COPY ./requirements/ /app/requirements/
COPY ./requirements.txt /app/requirements.txt

# set working directory to /app/
WORKDIR /app/

# install python dependencies
RUN pip install -r /app/requirements/dev.txt

EXPOSE 5000

# Define default command.
CMD gunicorn app:app -b :5000