# frozen_string_literal: true

# Represents an escape game. This may be one of many offered at the same
# location.
class EscapeGame < ApplicationRecord
  include Discard::Model
  has_many_attached :images
  has_many :clears

  belongs_to :user
  validates :name, presence: true
  validates :genre, presence: true
  enum genre: {
    modern: 0,
    other: 1,
    historical: 2,
    horror: 3,
    fantasy: 4,
    science: 5,
    abstract: 6,
    future: 7,
    military: 8,
    toy_room: 9,
    cartoon: 10,
    steampunk: 11,
    seasonal: 12
  }
  validates :summary, presence: true, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 5000 }
  validates :difficulty_level, presence: true
  enum difficulty_level: { beginner: 0, intermediate: 1, enthusiast: 2 }
  validates :available_time, presence: true
  # images
  validates :latitude, presence: true,
                       numericality: {
                         greater_than_or_equal_to: -90,
                         less_than_or_equal_to: 90
                       }
  validates :longitude, presence: true,
                        numericality: {
                          greater_than_or_equal_to: -180,
                          less_than_or_equal_to: 180
                        }
  validates :place_id, format: {
    with: /([A-z\-\d])*/, message: 'may not be a valid Google Maps Place ID'
  }
end
