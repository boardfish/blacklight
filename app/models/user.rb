# frozen_string_literal: true

# Model for user accounts. Users authenticate via Auth0 exclusively.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: %i[auth0]
  enum purpose: %i[maintainer enthusiast is_both]

  def onboarded?
    maintainer || enthusiast
  end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.nickname = auth.info.nickname
      # If you are using confirmable and the provider(s) you use validate
      # emails, uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  has_many :escape_games
end
