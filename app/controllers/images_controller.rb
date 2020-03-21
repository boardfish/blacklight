# frozen_string_literal: true

# Controller dedicated to deletion of images. May be used for more image-related
# actions in the future.
class ImagesController < ApplicationController
  before_action :set_image, only: %i[destroy]
  def destroy
    @image.purge
    respond_to do |format|
      format.html do
        redirect_to escape_games_url,
                    notice: 'Escape game was successfully destroyed.'
      end
      format.json { head :no_content }
      format.js   { render layout: false }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @escape_game = EscapeGame.find(params[:escape_game_id])
    @image = @escape_game.images.find(params[:id])
  end
end
