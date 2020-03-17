# frozen_string_literal: true

FactoryBot.define do
  factory :escape_game do
    name { 'Test Escape Room' }
    genre { :modern }
    summary { 'An exciting escape game!' }
    description do
      'This is a really long description of an escape game. It\'s
      very interesting, so give it a listen.
      '
    end
    difficulty_level { :beginner }
    available_time { 60 }
    latitude { 0 }
    longitude { 0 }
    place_id { 'ChIJrTLr-GyuEmsRBfy61i59si0' }
    user_id { create(:user).id }
  end
end
