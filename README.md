# Blacklight

![boardfish](https://circleci.com/gh/boardfish/blacklight.svg?style=svg)

A system for connecting escape room businesses with enthusiasts.

Developed with Ruby `2.7.0`, Rails `6.0.2`.

## Installation

Ensure that you have Docker and `docker-compose` installed and configured.

If you've run Blacklight previously, use `docker-compose down -v` to tear it
down.

### Setting required environment variables

Blacklight needs the following environment variables set in order to operate:

```
RAILS_HOST                | The domain at which Blacklight is hosted, e.g. 'example.com'
AUTH0_DOMAIN              | The domain Auth0 provides your application for authentication
AUTH0_CLIENT_ID           | The client ID for your application on Auth0.
AUTH0_CLIENT_SECRET       | The client secret for your application on Auth0.
GOOGLE_MAPS_EMBED_API_KEY | A valid API key for the Google Maps Embed API.
```

You'll also need to supply an API key for the frontend in `app/views/layouts/application.html.erb`. The app uses the Places, Geocoding, Embed and JavaScript APIs for Google Maps, so make sure you key has permissions for those.

You'll also need to configure your own storage service if you're deploying
Blacklight to production. Blacklight uses
[Google Cloud Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html#setup)
in production, so the `google-cloud-storage` gem comes as part of the Gemfile. Remove `config/credentials.yml.enc` and run `docker-compose exec -e EDITOR="vi" web bin/rails credentials:edit` to regenerate the file. Repeating the command will allow you to add the necessary credentials.

### Running

```
docker-compose build
docker-compose run web rake db:setup
docker-compose up
```

You'll then be able to access Blacklight on `localhost:3000`.

Using `docker-compose run web rake db:setup` creates the database in the
`postgresql` container. This will also seed the database with some escape room
data based on *Super Smash Bros. Ultimate* characters and stages.

This ought to take about five minutes, as images will be downloaded from SSBWiki
during seeding.

### Terminal access

For terminal access, run `docker-compose exec web bash` in another terminal
session. You can then use `bin/rails` and `rake` commands from there.

#### In production (Heroku)

Permissions are a pinch tighter in production, so you'll need to do the
following on Heroku:

1. Reset the database if you've tried before and something's gone wrong:

`heroku pg:reset`

2. Migrate the database with `heroku run rake db:migrate`.
3. Seed the database with `heroku run rake db:seed`.

##### Checkout steps

When deploying, manually run through and check that the...

- ...homepage renders correctly, particularly with regards to React components
  like the navbar (visual check)
- ...CSS is applied to the elements (visual check)
- ...Bootstrap JS from asset pipeline works (try to open the Filters dropdown on
  Explore)
- ...Auth0 login flow works - i.e. it's possible to log in and hold a session
- ...Auth0 logout flow works - i.e. it's possible to log out and your session is
  destroyed
- ...controllers work - i.e. Explore returns escape games if they exist. Create
  one if it does not exist and make sure that the list of escape games you own
  on your user#show page works.
- ...JS views work - i.e. it's possible to remove images from a listing and
  have the corresponding table row disappear

This process can be automated, but was not due to time constraints.

## Troubleshooting

### Permissions issues?

If `docker-compose build` reports permissions issues related to `tmp/db`, run 
`sudo chown -R $USER:$USER .` from the Blacklight directory and try again.

---

## Disclaimer for seed data

Under Section 107 of the Copyright Act 1976, allowance is made for "fair use"
for purposes such as criticism, commenting, news reporting, teaching,
scholarship, and research. Fair use is a use permitted by copyright statute that
might otherwise be infringing. Non-profit, educational or personal use tips the
balance in favour of fair use.

The seed data obtained from [SSBWiki](https://ssbwiki.com) of both text and
images relating to the *Super Smash Bros. Ultimate* video game is used only to
demonstrate the functionality of Blacklight when occupied by users and escape
games. It has no negative impact on the original works.
