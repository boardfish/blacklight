# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails' 

data = YAML.load_file(Rails.root.join('spec/fixtures/files/escape_game/data.yml')).deep_symbolize_keys
data[:users].each do |user|
  user_record = FactoryBot.create(:user, **user.except(:escape_games, :avatar))
  user[:escape_games].each do |eg_data|
    FactoryBot.create(:escape_game, **eg_data.except(:latitude, :longitude, :place_id, :images), user: user_record)
  end
end
User.where(enthusiast: true).each do |user|
  EscapeGame.order("RANDOM()").take(rand(EscapeGame.count - 1) + 1).each do |escape_game|
    Clear.create(user: user, escape_game: escape_game)
  end
end
# seed_user = FactoryBot.create(:user)
# 100.times do
#   FactoryBot.create(:escape_game, 
#     user: seed_user
#   )
# end
# Build blurhashes for newly attached images
EscapeGame.find_each(&:save)