# frozen_string_literal: true

# Represents a user's affirmation that they've completed a room.
class Clear < ApplicationRecord
  belongs_to :user
  belongs_to :escape_game
  has_many_attached :images
end
