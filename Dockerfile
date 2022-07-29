FROM ruby:3.1.2-bullseye
RUN apt-get update -qq
WORKDIR /webcheck
COPY Gemfile /webcheck/Gemfile
RUN bundle install

CMD ["ruby", "webcheck.rb"]
