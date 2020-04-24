import React from 'react'

export default ({ authenticityToken }) => (
  <form class="button_to" method="post" action="/users/auth/auth0">
    <input class="btn btn-primary" type="submit" value="Sign Up/Log In" />
    <input type="hidden" name="authenticity_token" value={authenticityToken} />
  </form>
)