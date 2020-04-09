
setup:
	pip install --upgrade pip
	pip install poetry
	brew install libmemcached

install:
	poetry install

build:
	poetry run python manage.py migrate
	poetry run python manage.py createsuperuser

docker_build:
	python manage.py migrate
	python manage.py collectstatic --noinput

load_data:
	poetry run python manage.py loaddata planets.json
	poetry run python manage.py loaddata people.json
	poetry run python manage.py loaddata species.json
	poetry run python manage.py loaddata transport.json
	poetry run python manage.py loaddata starships.json
	poetry run python manage.py loaddata vehicles.json
	poetry run python manage.py loaddata films.json

docker_load_data:
	python manage.py loaddata planets.json
	python manage.py loaddata people.json
	python manage.py loaddata species.json
	python manage.py loaddata transport.json
	python manage.py loaddata starships.json
	python manage.py loaddata vehicles.json
	python manage.py loaddata films.json

serve:
	poetry run python manage.py runserver

dump_data:
	poetry run python manage.py dumpdata resources.planet > resources/fixtures/planets.json --indent 4
	poetry run python manage.py dumpdata resources.people > resources/fixtures/people.json --indent 4
	poetry run python manage.py dumpdata resources.species > resources/fixtures/species.json --indent 4
	poetry run python manage.py dumpdata resources.starship > resources/fixtures/starships.json --indent 4
	poetry run python manage.py dumpdata resources.vehicle > resources/fixtures/vehicles.json --indent 4
	poetry run python manage.py dumpdata resources.transport > resources/fixtures/transport.json --indent 4
	poetry run python manage.py dumpdata resources.film > resources/fixtures/films.json --indent 4


drop_db:
	poetry run python manage.py flush

test:
	poetry run python manage.py test


clear_cache:
	poetry run python manage.py clear_cache
