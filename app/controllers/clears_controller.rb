# frozen_string_literal: true

# Controller for CRUD actions on Clear objects.
class ClearsController < ApplicationController
  before_action :set_clear, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /clears
  # GET /clears.json
  def index
    @clears_to_render = ClearService.cleared_games_for(current_user)
    @clears = @clears_to_render.map do |clear|
      {
        escape_game: clear.escape_game,
        clear: clear,
        cleared: true,
        images: clear.images.map { |image| { src: url_for(image) } }
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
          redirect_to @clear, notice: 'Clear was successfully updated.'
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

  # Only allow a list of trusted parameters through.
  def clear_params
    params.require(:clear).permit(
      :escape_game_id, :user_id, images: []
    )
  end
end
