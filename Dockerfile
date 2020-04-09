FROM python:2.7.13

RUN apt-key adv --keyserver hkp://pool.sks-keyservers.net:80 --recv-keys 9D6D8F6BC857C906 AA8E81B4331F7F50 7638D0442B90D010 7638D0442B90D010
RUN apt-get update && apt-get install -y libmemcached-dev --force-yes

WORKDIR /app
RUN pip install --upgrade pip
RUN pip install pipenv
COPY requirements.txt /app/

RUN pipenv install --deploy --system
COPY . /app/

RUN make build
RUN make load_data
RUN pipenv run python manage.py collectstatic --noinput
COPY . /app/

EXPOSE 8000

CMD ["gunicorn", "--bind=0.0.0.0", "swapi.wsgi", "--log-file", "-"]
