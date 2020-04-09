from __future__ import unicode_literals
import resources.schemas
import swapi.views
from resources import views
from rest_framework import routers

from django.conf.urls import url, include
from django.contrib import admin
admin.autodiscover()


router = routers.DefaultRouter()

router.register(r"people", views.PeopleViewSet)
router.register(r"planets", views.PlanetViewSet)
router.register(r"films", views.FilmViewSet)
router.register(r"species", views.SpeciesViewSet)
router.register(r"vehicles", views.VehicleViewSet)
router.register(r"starships", views.StarshipViewSet)


urlpatterns = [
    url(r"^admin/", admin.site.urls),
    url(r"^$", swapi.views.index),
    url(r"^documentation$", swapi.views.documentation),
    url(r"^about$", swapi.views.about),
    url(r"^stats$", swapi.views.stats),
    url(r"^stripe/donation", swapi.views.stripe_donation),
    url(r"^api/people/schema$", resources.schemas.people),
    url(r"^api/planets/schema$", resources.schemas.planets),
    url(r"^api/films/schema$", resources.schemas.films),
    url(r"^api/species/schema$", resources.schemas.species),
    url(r"^api/vehicles/schema$", resources.schemas.vehicles),
    url(r"^api/starships/schema$", resources.schemas.starships),
    url(r"^api/", include(router.urls)),
]
