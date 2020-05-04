FROM python:3.7.7-buster

RUN apt-get update && apt-get install -y libmemcached-dev

WORKDIR /app
RUN pip install --upgrade pip
RUN pip install poetry
COPY poetry.lock /app/
COPY pyproject.toml /app/

RUN POETRY_VIRTUALENVS_CREATE=false poetry install --ansi --no-interaction
COPY . /app/

RUN make docker_build
RUN make docker_load_data
COPY . /app/

CMD gunicorn --bind=0.0.0.0:$PORT swapi.wsgi --log-file -
