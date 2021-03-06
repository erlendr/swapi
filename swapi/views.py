from __future__ import unicode_literals

from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt
from django.core.cache import cache
from django.conf import settings
from django.contrib.auth.decorators import login_required

import stripe

from resources.utils import get_resource_stats

DEFAULT_HITS = 50000


def index(request):

    stripe_key = settings.STRIPE_KEYS['publishable']
    return render(
        request,
        'index.html',
        {
            "stripe_key": stripe_key
        }
    )


def documentation(request):
    return render(request, "documentation.html")


def about(request):
    stripe_key = settings.STRIPE_KEYS['publishable']
    data = cache.get('resource_data')
    if not data:
        data = get_resource_stats()
        cache.set('resource_data', data, 10000)
    data['stripe_key'] = stripe_key
    return render(
        request,
        "about.html",
        data
    )


@csrf_exempt
def stripe_donation(request):
    if request.method == 'POST':
        # Amount in cents
        amount = 1000

        stripe.api_key = settings.STRIPE_KEYS['secret']

        customer = stripe.Customer.create(
            email=request.POST.get('stripeEmail', ''),
            card=request.POST.get('stripeToken', '')
        )

        try:
            stripe.Charge.create(
                customer=customer.id,
                amount=amount,
                currency='usd',
                description='SWAPI donation'
            )
        except Exception:
            pass

        return redirect('/')
    return redirect('/')


@login_required
def stats(request):
    data = {}
    return render(
        request,
        'stats.html',
        data
    )
