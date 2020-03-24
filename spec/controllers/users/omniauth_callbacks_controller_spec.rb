# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user] # If using Devise
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:auth0]
  end

  it 'creates a user through Auth0' do
    expect { post :auth0 } .to change(User, :count).by(1)
    expect(User.last.uid).to eq('1')
    expect(User.last.name).to eq('Foo Bar')
    expect(User.last.nickname).to eq('foo')
    expect(User.last.email).to eq('foo@bar.com')
  end
end
