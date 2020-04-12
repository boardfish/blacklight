# Blacklight

A system for connecting escape room businesses with enthusiasts.

Developed with Ruby `2.7.0`, Rails `6.0.2`.

## Installation and running

Ensure that you have Docker and `docker-compose` installed and configured.

If you've run Blacklight previously, use `docker-compose down -v` to tear it
down.

```
docker-compose build && docker-compose up
```

You'll then be able to access Blacklight on `localhost:3000`.

For terminal access, run `docker-compose exec web bash` in another terminal
session. You can then use `rails` and `rake` commands from there.

### Bootstrapping the database

Use `docker-compose exec web rake db:setup` to create the database in the
`postgresql` container. This will also seed the database with some escape room
data based on *Super Smash Bros. Ultimate* characters and stages.

This ought to take about five minutes, as images will be downloaded from SSBWiki
during seeding.

#### In production (Heroku)

Permissions are a pinch tighter in production, so you'll need to do the
following:

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