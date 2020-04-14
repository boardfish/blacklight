# frozen_string_literal: true

# Model for user accounts. Users authenticate via Auth0 exclusively.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: %i[auth0]
  enum purpose: %i[maintainer enthusiast is_both]
  has_many :clears
  has_many :escape_games
  has_one_attached :avatar

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

  def bio
    public ? super : nil
  end

  def location
    public ? super : nil
  end

  def website
    public ? super : nil
  end
end
