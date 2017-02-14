FROM ruby:2.3

RUN apt-get update
RUN apt-get install nodejs -y
RUN apt-get install vim -y

RUN mkdir -p /var/www/vendas
WORKDIR /var/www/vendas

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . /var/www/vendas

