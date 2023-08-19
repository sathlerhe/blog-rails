FROM ruby:3.2.2 as base

RUN gem install bundler
WORKDIR /blog_rails
COPY . ./
RUN bundle install
CMD ["rails", "server", "-b", "0.0.0.0"]
