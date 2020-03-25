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
data based on Faker::Games::SuperSmashBros.stage. If you'd like to attach images
too, you can retrieve these by running the script in
`spec/fixtures/files/escape_game`.

### Permissions issues?

If `docker-compose build` reports permissions issues related to `tmp/db`, run 
`sudo chown -R $USER:$USER .` from the Blacklight directory and try again.


## To be documented

* Configuration
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions