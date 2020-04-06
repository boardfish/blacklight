# frozen_string_literal: true

# Service for searching and clearing escape games, as used by the controller
class EscapeGameService
  include Rails.application.routes.url_helpers

  class << self
    def search_with_clears(user, query, difficulty)
      new(user, nil).tap do |egs|
        egs.escape_games = egs.search(query, difficulty)
        return egs.list_clears
      end
    end

    def set_cleared(escape_game, user, cleared)
      if cleared
        Clear.where(user: user, escape_game: escape_game).first_or_create
      else
        Clear.where(user: user, escape_game: escape_game).last.destroy!
      end
    end

    def list_with_clears(user, games)
      new(user, games).list_clears
    end
  end

  def initialize(user, escape_games)
    @escape_games = [escape_games]
    if @escape_games.first.is_a?(ActiveRecord::Relation)
      @escape_games = @escape_games.first
    end
    @escape_games = escape_games
    @user = user
  end

  def search(query, difficulty)
    params = {}
    params[:name_cont] = query if query
    params[:difficulty_level_eq] = difficulty if difficulty
    EscapeGame.kept.where.not(user: @user).ransack(params).result
  end

  attr_writer :escape_games

  # for each escape_game, list whether the user has a Clear with it.

  def explore_thumbnail_for(image)
    return unless image

    rails_representation_url(
      image.variant(resize_to_limit: [350, 350]),
      only_path: true
    )
  end

  def list_clears
    @escape_games.joins(:clears).includes(:user).with_attached_images.map do |e|
      image_path = explore_thumbnail_for(e.images&.first)
      {
        escape_game: e,
        cleared: e.clears.exists?(user: @user),
        image_path: image_path,
        user: {
          avatar: e.user.avatar.attached? ? url_for(e.user.avatar) : nil,
          id: e.user.id
        }
      }
    end
  end
end
