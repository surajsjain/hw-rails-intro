FROM ruby:2.5

RUN mkdir /code
WORKDIR /code

COPY Gemfile /code/
COPY Gemfile.lock /code/
RUN bundle install --without production

COPY . /code/

RUN rake db:migrate
RUN rake db:seed

EXPOSE 8080
EXPOSE 80

CMD rails s -p 8080
