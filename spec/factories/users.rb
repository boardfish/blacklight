# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    nickname { Faker::Internet.unique.username }
    maintainer { [true, false].sample }
    enthusiast { [true, false].sample }

    public { true }

    website { 'https://simon.fish' }
  end
end
