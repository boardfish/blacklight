# frozen_string_literal: true

# Returns cleared games for a user.
module ClearService
  class << self
    def cleared_games_for(user)
      Clear.where(user: user).includes(:escape_game).with_attached_images
    end
  end
end
