#!/bin/bash
docker rm --force swapi
docker run -p 8000:80 -it --name swapi swapi:1.0
