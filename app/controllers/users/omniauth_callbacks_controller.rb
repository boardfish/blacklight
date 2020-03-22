# frozen_string_literal: true

# Manage OmniAuth callbacks for Auth0.
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  LOGIN_SUCCESS_NOTICE_CONTENT = {
    title: 'Logged in successfully!',
    content: 'Welcome to Blacklight. You\'re now logged in!'
  }.freeze
  def auth0
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      # this will throw if @user is not activated
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = LOGIN_SUCCESS_NOTICE_CONTENT if is_navigational_format?
    else
      session[devise.auth0_data] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
