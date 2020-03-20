# frozen_string_literal: true

FactoryBot.define do
  factory :escape_game do
    name { Faker::Games::SuperSmashBros.stage }
    genre { :modern }
    summary { Faker::Lorem.sentence(word_count: 5) }
    description { Faker::Lorem.paragraphs.join('\n') }
    difficulty_level { :beginner }
    available_time { Random.rand(30..150) }
    latitude { 0 }
    longitude { 0 }
    place_id { 'ChIJrTLr-GyuEmsRBfy61i59si0' }
    user_id { User.count > 2 ? User.all.sample.id : create(:user).id }
  end
end
