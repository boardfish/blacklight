# frozen_string_literal: true

FactoryBot.define do
  factory :clear do
    user { random_user }
    escape_game do
      EscapeGame.order(Arel.sql('RANDOM()')).first || create(:escape_game)
    end
  end
end
