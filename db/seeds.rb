# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails' 

data = YAML.load_file(Rails.root.join('spec/fixtures/files/escape_game/data.yml')).deep_symbolize_keys
require "csv"
CSV.open(Rails.root.join('spec/fixtures/files/escape_game/seeded_records.csv'), "wb") do |csv|
  csv << ["id", "nickname", "email", "maintainer", "enthusiast", "public"]
end

# Seed users explicitly outlined in db file
data[:users].each do |user|
  user_record = FactoryBot.create(:user, **user.except(:escape_games, :avatar))
  CSV.open(
    Rails.root.join('spec/fixtures/files/escape_game/seeded_records.csv'), "a+"
    ) do |csv|
    csv << [
      user_record.id,
      user_record.nickname,
      user_record.email,
      user_record.maintainer,
      user_record.enthusiast,
      user_record.public
    ]
  end
  user[:escape_games].each do |eg_data|
    FactoryBot.create(:escape_game, **eg_data.except(:latitude, :longitude, :place_id, :images), user: user_record)
  end
end

# Give enthusiasts random clears
User.where(enthusiast: true).each do |user|
  EscapeGame.order("RANDOM()").take(rand(EscapeGame.count - 1) + 1).each do |escape_game|
    Clear.create(user: user, escape_game: escape_game)
  end
end
# Build blurhashes for newly attached images
EscapeGame.find_each(&:save)