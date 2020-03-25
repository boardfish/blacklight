# frozen_string_literal: true

FactoryBot.define do
  factory :escape_game do
    name { Faker::Games::SuperSmashBros.unique.stage }
    genre { EscapeGame.genres.keys.sample }
    summary { Faker::Lorem.sentence(word_count: 5) }
    description { Faker::Lorem.paragraphs.join('\n') }
    difficulty_level { EscapeGame.difficulty_levels.keys.sample }
    available_time { Random.rand(30..150) }
    latitude { 0 }
    longitude { 0 }
    place_id { 'ChIJrTLr-GyuEmsRBfy61i59si0' }
    user_id { User.count > 2 ? User.all.sample.id : create(:user).id }
    after(:build) do |escape_game|
      begin
        escape_game.images.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'escape_game', "SSBU-#{URI::encode(escape_game.name.tr(" ", "_")).to_s}.png")),
          filename: "SSBU-#{URI::encode(escape_game.name.tr(" ", "_")).to_s}.png",
          content_type: 'image/png')
      rescue Errno::ENOENT
      end
    end
  end
end
