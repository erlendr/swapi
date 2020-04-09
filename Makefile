
setup:
	pip install --upgrade pip
	pip install pipenv

install:
	pipenv install

build:
	pipenv run python manage.py migrate
	pipenv run python manage.py createsuperuser

docker_build:
	python manage.py migrate
	python manage.py collectstatic --noinput

load_data:
	pipenv run python manage.py loamakddata planets.json
	pipenv run python manage.py loaddata people.json
	pipenv run python manage.py loaddata species.json
	pipenv run python manage.py loaddata transport.json
	pipenv run python manage.py loaddata starships.json
	pipenv run python manage.py loaddata vehicles.json
	pipenv run python manage.py loaddata films.json

docker_load_data:
	python manage.py loaddata planets.json
	python manage.py loaddata people.json
	python manage.py loaddata species.json
	python manage.py loaddata transport.json
	python manage.py loaddata starships.json
	python manage.py loaddata vehicles.json
	python manage.py loaddata films.json

serve:
	pipenv run python manage.py runserver

dump_data:
	pipenv run python manage.py dumpdata resources.planet > resources/fixtures/planets.json --indent 4
	pipenv run python manage.py dumpdata resources.people > resources/fixtures/people.json --indent 4
	pipenv run python manage.py dumpdata resources.species > resources/fixtures/species.json --indent 4
	pipenv run python manage.py dumpdata resources.starship > resources/fixtures/starships.json --indent 4
	pipenv run python manage.py dumpdata resources.vehicle > resources/fixtures/vehicles.json --indent 4
	pipenv run python manage.py dumpdata resources.transport > resources/fixtures/transport.json --indent 4
	pipenv run python manage.py dumpdata resources.film > resources/fixtures/films.json --indent 4


drop_db:
	pipenv run python manage.py flush

test:
	pipenv run python manage.py test


clear_cache:
	pipenv run python manage.py clear_cache
