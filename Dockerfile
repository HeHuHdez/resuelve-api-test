FROM ruby:2.6.5

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN gem install bundler -v '2.1.4'
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle
RUN bundle binstub guard rspec-core puma
RUN yarn install --check-files
ADD . /myapp
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]