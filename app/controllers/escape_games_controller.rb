# frozen_string_literal: true

# Controller for dealing with the Escape Game model.
class EscapeGamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_escape_game, only: %i[show cleared]
  before_action :set_user_escape_game, only: %i[edit update destroy]

  I18N_HASH = I18n.t('controllers.escape_games')

  # GET /escape_games
  # GET /escape_games.json
  def index
    @escape_games = current_user.escape_games.kept
  end

  # GET /escape_games/explore
  # GET /escape_games/explore.json
  def explore
    @escape_games = EscapeGameService.search_with_clears(
      current_user, params[:q], params[:difficulty]
    )
    respond_to do |format|
      format.html do
        render :explore
      end
      format.json do
        render json: @escape_games, status: :ok
      end
    end
  end

  # GET /escape_games/1
  # GET /escape_games/1.json
  def show
    @related_escape_games = EscapeGameService.list_with_clears(
      current_user,
      @escape_game.user.escape_games.where.not(id: @escape_game.id)
    )
  end

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
          redirect_to @escape_game, notice: I18N_HASH.dig(:create, :success)
        end
        format.json do
          render :show, status: :created, location: @escape_game
        end
      else
        format.html { render :new }
        format.json do
          render json: @escape_game.errors, status: :unprocessable_entity
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
          redirect_to @escape_game, notice: I18N_HASH.dig(:update, :success)
        end
        format.json { render :show, status: :ok, location: @escape_game }
      else
        format.html { render :edit }
        format.json do
          render json: @escape_game.errors, status: :unprocessable_entity
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
        redirect_to escape_games_url, notice: I18N_HASH.dig(:destroy, :success)
      end
      format.json { head :no_content }
    end
  end

  def cleared
    EscapeGameService.set_cleared(@escape_game, current_user, params[:cleared])
    respond_to do |format|
      format.html do
        redirect_to @escape_game, notice: I18N_HASH.dig(:cleared, :success)
      end
      format.json { head :no_content }
    end
  end

  def already_cleared
    respond_to do |format|
      format.json { render json: { cleared: true } }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_escape_game
    @escape_game = EscapeGame.find(params[:id])
  end

  def set_user_escape_game
    @escape_game = current_user.escape_games.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def escape_game_params
    params.require(:escape_game).permit(
      :name, :genre, :summary, :description,
      :difficulty_level, :available_time, :website_link, :place_id, :latitude,
      :longitude, :visible, :user_id, images: []
    )
  end
end
