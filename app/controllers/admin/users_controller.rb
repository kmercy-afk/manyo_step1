class Admin::UsersController < ApplicationController
  before_action :admin_required
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.includes(:tasks).order(created_at: :desc)
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(admin_user_params)

    if @user.save
      redirect_to admin_users_path, notice: 'You have registered a user'
    else
      render :new
    end
  end

  def update
    if @user.update(admin_user_params)
      redirect_to admin_users_path, notice: 'Updated users'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'You have deleted a user'
    else
      redirect_to admin_users_path, alert: @user.errors.full_messages.join(', ')
    end
  end

  private

  def admin_required
    return if current_user.admin?

    redirect_to tasks_path, alert: 'Only administrators can access'
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user_params
    permitted_params = params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :admin
    )

    if permitted_params[:password].blank?
      permitted_params.delete(:password)
      permitted_params.delete(:password_confirmation)
    end

    permitted_params
  end
end