FROM python:3.8.3-buster
WORKDIR /app
COPY . /app 
RUN apt update -y
RUN apt upgrade -y
RUN apt install curl -y
#RUN set -x
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH /root/.poetry/bin:$PATH
ENV PATH /root//.local/bin:$PATH
ENV DATABASE_URL="postgres://t4lite:o4geiDjZqoFH9mv@top2.nearest.of.t4lite-db.internal:5432/t4lite?sslmode=disable"

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
wget http://dl.google.com/linux/deb/pool/main/g/google-chrome-unstable/google-chrome-unstable_110.0.5481.30-1_amd64.deb && \
apt-get install -y -f ./google-chrome-unstable_110.0.5481.30-1_amd64.deb

ADD https://chromedriver.storage.googleapis.com/110.0.5481.30/chromedriver_linux64.zip /app
RUN cd /app/ && \
unzip chromedriver_linux64.zip

RUN poetry config virtualenvs.create false
 
COPY pyproject.toml ./
RUN poetry install --no-root --no-dev
#CMD gunicorn view:server
#CMD python T4lite.py