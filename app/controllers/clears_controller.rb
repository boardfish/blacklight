# frozen_string_literal: true

# Controller for CRUD actions on Clear objects.
class ClearsController < ApplicationController
  before_action :set_clear, only: %i[show]
  before_action :set_user_clear, only: %i[edit update destroy]
  before_action :authenticate_user!

  # GET /clears
  # GET /clears.json
  def index
    user = params[:user_id] ? User.find_by!(public: true, id: params[:user_id]) : current_user
    @clears_to_render = ClearService.cleared_games_for(user)
    @clears = @clears_to_render.map do |clear|
      {
        escape_game: clear.escape_game,
        clear: clear,
        cleared: true,
        images: clear.images.map do |image|
                  {
                    src: url_for(image),
                    signed_id: image.signed_id
                  }
                end
      }
    end
    @all_images = @clears_to_render.map(&:images).flatten.map do |image|
      { src: url_for(image) }
    end
  end

  # GET /clears/1
  # GET /clears/1.json
  def show; end

  # GET /clears/new
  def new
    @clear = Clear.new
  end

  # GET /clears/1/edit
  def edit; end

  # POST /clears
  # POST /clears.json
  def create
    @clear = Clear.new(clear_params)

    respond_to do |format|
      if @clear.save
        format.html do
          redirect_to @clear, notice: 'Clear was successfully created.'
        end
        format.json { render :show, status: :created, location: @clear }
      else
        format.html { render :new }
        format.json do
          render json: @clear.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /clears/1
  # PATCH/PUT /clears/1.json
  def update
    respond_to do |format|
      if @clear.update(clear_params)
        format.html do
          redirect_to clears_path, notice: {
            title: 'Images attached!',
            content: 'You\'ve successfully attached images. What a way to' \
            ' mark your victory!'
          }
        end
        format.json { render :show, status: :ok, location: @clear }
      else
        format.html { render :edit }
        format.json do
          render json: @clear.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /clears/1
  # DELETE /clears/1.json
  def destroy
    @clear.destroy
    respond_to do |format|
      format.html do
        redirect_to clears_url, notice: 'Clear was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_clear
    @clear = Clear.find(params[:id])
  end

  def set_user_clear
    @clear = current_user.clears.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def clear_params
    params.require(:clear).permit(
      :escape_game_id, :user_id, images: []
    )
  end
end
