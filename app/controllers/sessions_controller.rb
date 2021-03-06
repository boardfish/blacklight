# frozen_string_literal: true

# Overrides for OmniAuth in Devise.
class SessionsController < ApplicationController
  def new
    # redirect_to user_auth0_omniauth_authorize_path, method: 'post'
  end

  def destroy
    (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    redirect_to logout_url.to_s
    nil
  end

  private

  def logout_url
    domain = ENV.fetch('AUTH0_DOMAIN')
    client_id = ENV.fetch('AUTH0_CLIENT_ID')
    request_params = {
      returnTo: root_url,
      client_id: client_id
    }

    URI::HTTPS.build(
      host: domain, path: '/v2/logout', query: to_query(request_params)
    )
  end

  def to_query(hash)
    hash.map do |k, v|
      "#{k}=#{CGI.escape(v)}" unless v.nil?
    end .reject(&:nil?).join('&')
  end
end
