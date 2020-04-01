# frozen_string_literal: true

FactoryBot.define do
  factory :clear do
    user { random_user }
    escape_game { EscapeGame.order(Arel.sql('RANDOM()')).first }
  end
end
