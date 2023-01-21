FROM python:3.7.16-buster
RUN apt-get upgrade -y
RUN apt-get update -y
RUN ap-get install -y python3 python3-pip \
    && apk add libpq postgresql-dev \
    && apk add build-base
COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
COPY . /view
CMD ["gunicorn", "-b", "0.0.0.0:8080", "--workers", "3", "app:app"] 