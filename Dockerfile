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
RUN poetry config virtualenvs.create false
 
COPY pyproject.toml ./
RUN poetry install --no-root --no-dev