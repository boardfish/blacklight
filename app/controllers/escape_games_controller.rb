# frozen_string_literal: true

# Controller for dealing with the Escape Game model.
class EscapeGamesController < ApplicationController
  before_action :set_escape_game, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /escape_games
  # GET /escape_games.json
  def index
    @escape_games = current_user.escape_games.kept
  end

  # GET /escape_games/1
  # GET /escape_games/1.json
  def show; end

  # GET /escape_games/new
  def new
    @escape_game = EscapeGame.new(user: current_user)
  end

  # GET /escape_games/1/edit
  def edit; end

  # POST /escape_games
  # POST /escape_games.json
  def create
    @escape_game = EscapeGame.new(escape_game_params.merge(user: current_user))

    respond_to do |format|
      if @escape_game.save
        format.html do
          redirect_to @escape_game,
                      notice: 'Escape game was successfully created.'
        end
        format.json do
          render :show,
                 status: :created,
                 location: @escape_game
        end
      else
        format.html { render :new }
        format.json do
          render json: @escape_game.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /escape_games/1
  # PATCH/PUT /escape_games/1.json
  def update
    respond_to do |format|
      if @escape_game.update(escape_game_params.merge(user: @escape_game.user))
        format.html do
          redirect_to @escape_game,
                      notice: 'Escape game was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @escape_game }
      else
        format.html { render :edit }
        format.json do
          render json:
          @escape_game.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /escape_games/1
  # DELETE /escape_games/1.json
  def destroy
    @escape_game.discard
    respond_to do |format|
      format.html do
        redirect_to escape_games_url,
                    notice: 'Escape game was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_escape_game
    @escape_game = EscapeGame.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def escape_game_params
    if params.require(:escape_game) == '1'
      params[:escape_game]
    else
      params.require(:escape_game).permit(
        :name, :genre, :summary, :description,
        :difficulty_level, :available_time, :website_link, :place_id, :latitude,
        :longitude, :visible, :user_id
      )
    end
  end
end
