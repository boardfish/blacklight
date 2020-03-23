# frozen_string_literal: true

# Helper class for views under the escape games controller.
module EscapeGamesHelper
  def cleared?(escape_game: @escape_game)
    escape_game.clears.where(user: current_user).any?
  end
end
