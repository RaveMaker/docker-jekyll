FROM jekyll/jekyll:latest as Builder

RUN mkdir -p /dist

WORKDIR /srv/jekyll

COPY jekyll/Gemfile .

RUN bundle install

COPY jekyll .

RUN chown 1000:1000 -R /srv/jekyll /dist

RUN jekyll build -d /dist

FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY --from=Builder /dist .
