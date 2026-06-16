class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  before_action :logout_required, only: %i[new create]
  before_action :set_user, only: %i[show edit update]
  before_action :correct_user, only: %i[show edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: 'I have registered an account'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user),
                  notice: 'Your account has been updated'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    return if current_user == @user

    redirect_to tasks_path,
                alert: 'You do not have permission to access'
  end

  def user_params
    permitted_params = params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )

    if permitted_params[:password].blank?
      permitted_params.delete(:password)
      permitted_params.delete(:password_confirmation)
    end

    permitted_params
  end
end