# frozen_string_literal: true

json.extract! escape_game, :id, :name, :genre, :summary, :description, :difficulty_level, :available_time, :website_link, :place_id, :latitude, :longitude, :visible, :user_id, :created_at, :updated_at
json.url escape_game_url(escape_game, format: :json)
