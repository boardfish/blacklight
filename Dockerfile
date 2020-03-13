FROM ruby:2.7
RUN apt-get -qq update && apt-get -qq install -y nodejs npm postgresql-client
RUN mkdir /blacklight
WORKDIR /blacklight
COPY Gemfile /blacklight/Gemfile
COPY Gemfile.lock /blacklight/Gemfile.lock
RUN bundle install --quiet
COPY . /blacklight
RUN npm install -g yarn && yarn install --check-files

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
