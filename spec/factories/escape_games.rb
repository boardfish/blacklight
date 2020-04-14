# frozen_string_literal: true

require_relative '../../lib/ssb_wiki_image_seeder/ssb_wiki_image_seeder.rb'

escape_game_locations = [
  {
    name: 'Escape Sheffield',
    location: {
      latitude: 53.383185,
      longitude: -1.4692497,
      place_id: 'ChIJwdi-9Hh4eUgRHEN41OxhzWI'
    }
  },
  {
    name: 'The Lockup',
    location: {
      latitude: 53.372737,
      longitude: -1.4791317,
      place_id: 'ChIJi7lSbn2CeUgRu1cfaY7Rv-I'
    }
  },
  {
    name: 'One Way Out',
    location: {
      latitude: 52.67141,
      longitude: -0.7372267,
      place_id: 'ChIJm3dsWsWBd0gRSawbLAXNxiY'
    }
  },
  {
    name: 'The Great Escape Game Sheffield',
    location: {
      latitude: 53.376308,
      longitude: -1.4697997,
      place_id: 'ChIJdVSTEISCeUgRbiE-i1PLblA'
    }
  }
]

FactoryBot.define do
  factory :escape_game do
    transient do
      location { escape_game_locations.sample }
    end
    name { Faker::Games::SuperSmashBros.unique.stage }
    genre { EscapeGame.genres.keys.sample }
    summary { Faker::Lorem.sentence(word_count: 5) }
    description { '# ' + Faker::Lorem.paragraphs.join("\n\n") }
    difficulty_level { EscapeGame.difficulty_levels.keys.sample }
    available_time { Random.rand(30..150) }
    latitude { location.dig(:location, :latitude) }
    longitude { location.dig(:location, :longitude) }
    place_id { location.dig(:location, :place_id) }
    user_id { User.count > 2 ? User.all.sample.id : create(:user).id }
    after(:build) do |escape_game|
      image_link = SSBWikiImageSeeder.new(
        '%s/File:SSBU-%s.%s'
      ).get_direct_link_any_type(escape_game.name)
      # can't return
      if image_link
        escape_game.images.attach(
          io: image_link.open,
          filename: "SSBU-#{CGI.escape(escape_game.name.tr(' ', '_'))}.png",
          content_type: 'image/png'
        )
      end
    rescue Errno::ENOENT
    end
  end
end
