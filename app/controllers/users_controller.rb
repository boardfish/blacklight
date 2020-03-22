# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy maintainer enthusiast maintainer_and_enthusiast]

  # GET /users/1
  # GET /users/1.json
  def show; end
  
  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def make_user_a(user_type)

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def maintainer
    @user.maintainer = true
    if @user.save
      redirect_to edit_user_path(@user), notice: { title: 'You\'re now a maintainer!', content: 'You can now use maintainer tools to show your escape room on the site!'}
    else
      redirect_to root_path, alert: {title: 'Unable to save...', content: 'Unfortunately, we couldn\'t make you a maintainer.'}
    end
  end

  def enthusiast
    @user.enthusiast = true
    if @user.save
      redirect_to edit_user_path(@user), notice: { title: 'You\'re now an enthusiast!', content: 'Take a look around and see if you can find your next adventure.'}
    else
      redirect_to root_path, alert: {title: 'Unable to save...', content: 'Unfortunately, we couldn\'t make you an enthusiast.'}
    end
  end

  def maintainer_and_enthusiast
    @user.enthusiast = true
    @user.maintainer = true
    if @user.save
      redirect_to edit_user_path(@user), notice: { title: 'Jack of all trades!', content: 'You can now use maintainer tools, but we\'ll also help you find other escape rooms to try.'}
    else
      redirect_to root_path, alert: {title: 'Unable to save...', content: 'Unfortunately, we couldn\'t make you an enthusiast.'}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    if params.require(:user) == '0'
      params[:user]
    else
      params.require(:user).permit(:maintainer, :enthusiast)
    end
  end
end
