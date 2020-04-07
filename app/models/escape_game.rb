# frozen_string_literal: true

require 'rmagick'

# Represents an escape game. This may be one of many offered at the same
# location.
module DefaultImage
  def default_image
    if super.attached?
      return super
    else
      return images.first 
    end
  end
end

class EscapeGame < ApplicationRecord
  prepend DefaultImage
  include Discard::Model
  has_many_attached :images
  has_one_attached :default_image
  has_many :clears, dependent: :destroy
  before_save :build_blurhash

  scope :by, ->(user_id) { where(user_id: user_id) }
  scope :all_but, ->(escape_game) { where.not(id: escape_game.id) }

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

  def google_maps_url
    'https://www.google.com/maps/search/' \
    "?api=1&query=#{latitude},#{longitude}&query_place_id=#{place_id}"
  end

  private

  def build_blurhash
    return unless default_image.attached?

    default_image.open do |file|
      @image = Magick::ImageList.new(file.path)
    end
    self.blurhash = Blurhash.encode(
      @image.columns, @image.rows, @image.export_pixels
    )
  rescue ActiveStorage::FileNotFoundError
    # This happens when a new record has been made and the attached image isn't
    # on the record yet.
  end
end
