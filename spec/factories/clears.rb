# frozen_string_literal: true

FactoryBot.define do
  factory :clear do
    user_id { random_user.id }
    escape_game_id do
      (EscapeGame.order(Arel.sql('RANDOM()')).first || create(:escape_game)).id
    end
  end
end
