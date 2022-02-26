FROM node:16
FROM ruby:2.6.6

RUN mkdir /code
WORKDIR /code

COPY Gemfile /code/
COPY Gemfile.lock /code/
RUN bundle install --without production
RUN gem install execjs

COPY . /code/

RUN rake db:migrate
RUN rake db:seed

EXPOSE 8080
EXPOSE 80

# CMD ["rails", "server", "-b", "0.0.0.0"]
