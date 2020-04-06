# frozen_string_literal: true

# Controller that allows users to show and update their profiles.
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, only: %i[
    edit update destroy maintainer enthusiast maintainer_and_enthusiast
  ]
  before_action :set_user, only: %i[
    show
  ]

  I18N_HASH = I18n.t('controllers.users')

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/1/edit
  def edit; end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to @user,
                      notice: I18N_HASH.dig(:update, :success)
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: I18N_HASH.dig(:destroy, :success)
      end
      format.json { head :no_content }
    end
  end

  def maintainer
    @user.maintainer = true
    if @user.save
      redirect_to edit_user_path(@user),
                  notice: I18N_HASH.dig(:maintainer, :success)
    else
      redirect_to root_path, alert: I18N_HASH.dig(:maintainer, :failure)
    end
  end

  def enthusiast
    @user.enthusiast = true
    if @user.save
      redirect_to edit_user_path(@user),
                  notice: I18N_HASH.dig(:enthusiast, :success)
    else
      redirect_to root_path, alert: I18N_HASH.dig(:enthusiast, :failure)
    end
  end

  def maintainer_and_enthusiast
    @user.enthusiast = true
    @user.maintainer = true

    if @user.save
      redirect_to edit_user_path(@user),
                  notice: I18N_HASH.dig(:maintainer_and_enthusiast, :success)
    else
      redirect_to root_path,
                  alert: I18N_HASH.dig(:maintainer_and_enthusiast, :failure)
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by!(id: params[:id], public: true)
    @related_escape_games = EscapeGameService.list_with_clears(
      current_user,
      @user.escape_games
    )
  end

  def set_current_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(
      :maintainer, :enthusiast, :avatar, :bio, :location, :website, :public
    )
  end
end
