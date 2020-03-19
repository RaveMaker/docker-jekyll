# Docker: Jekyll
Dockerfile for Jekyll.

docker-compose file includes:
 - Jekyll New - Creates a new Jekyll website in `jekyll-new` folder
 - Jekyll Dev - `jekyll serve`
 - Jekyll Prod - `jekyll build` and serve with nginx
 - Traefik support for Production and Development

## Setup
1. clone the repo
2. create `.env` file from `.env.example`

## Create new Jekyll website
1. create folder `jekyll-new`
2. change ownership of jekyll-new folder `chown 1000:1000 jekyll-new -R`
3. run `docker-compose -f docker-compose.new.yml up`

## Development
1. create folder `jekyll` and copy your Jekyll project there.
2. change ownership of jekyll folder `chown 1000:1000 jekyll -R`
3. run `docker-compose -f docker-compose.dev.yml up`

Jekyll will watch the `jekyll` folder and will rebuild the site
when a change is made to any of the files.

## Production
1. create folder `jekyll` and copy your Jekyll project there.
2. change ownership of jekyll folder `chown 1000:1000 jekyll -R`
3. run `docker-compose up`

Jekyll will build the static site from the `jekyll` folder and docker
will copy it to a new nginx-alpine container without the build tools.
That way we get a clean nginx production container that
contains the static website.

## Network settings:
Container is connected to to a unique network named stack-name_frontend such as:

- docker-jekyll_frontend

after running docker-compose up you need to connect your reverse proxy to your new frontend network,
 you can do that manually using:
 
```
 docker network connect docker-jekyll_dev_frontend PROXY_CONTAINER_NAME
 docker network connect docker-jekyll_prod_frontend PROXY_CONTAINER_NAME
 ```

if you are using my Traefik setup there is a `connect.sh` script included that will connect all your frontend networks to your Traefik container.

Author: [RaveMaker][RaveMaker].

[RaveMaker]: http://ravemaker.net
