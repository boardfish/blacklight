# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails' 

seed_user = FactoryBot.create(:user)
100.times do
  FactoryBot.create(:escape_game, 
    user: seed_user
  )
end
# Build blurhashes for newly attached images
EscapeGame.find_each(&:save)