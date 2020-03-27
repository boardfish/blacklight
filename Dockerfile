FROM ruby:2.7
ENV RUBYOPT='-W:no-deprecated -W:no-experimental'
RUN apt-get -qq update && apt-get -qq install -y postgresql-client
RUN apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt -y install nodejs
RUN mkdir /blacklight
WORKDIR /blacklight
ENV BUNDLE_PATH /bundle_cache
COPY . /blacklight
RUN npm install -g yarn && yarn install --check-files

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
