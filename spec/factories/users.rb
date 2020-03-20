# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    nickname { Faker::Internet.unique.username }
  end
end
