# frozen_string_literal: true

# Manage OmniAuth callbacks for Auth0.
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def auth0
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      # this will throw if @user is not activated
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message(:notice, :success, kind: 'Auth0')
        flash[:notice] = {
          title: 'Logged in successfully!',
          content: 'Welcome to Blacklight. You\'re now logged in!'
        }
      end
    else
      session[devise.auth0_data] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
