# laravel-circleci-image
Docker image built for CircleCI with a few added packages for Laravel


To build current version for local testing:

    docker build -t internachi/laravel-circleci-image:dev .

To run the current build:

     docker run --rm -it internachi/laravel-circleci-image:dev bash

To push and tag the current local dev build:

```
docker tag internachi/laravel-circleci-image:dev \
    internachi/laravel-circleci-image:8.0-latest \
    && docker push internachi/laravel-circleci-image:8.0-latest
```
