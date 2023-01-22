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
ENV DATABASE_URL=postgres://t4lite:o4geiDjZqoFH9mv@top2.nearest.of.t4lite-db.internal:5432/t4lite?sslmode=disable

RUN poetry config virtualenvs.create false
 
COPY pyproject.toml ./
RUN poetry install --no-root --no-dev
CMD gunicorn view:server