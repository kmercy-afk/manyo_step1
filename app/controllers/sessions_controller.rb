class SessionsController < ApplicationController
  skip_before_action :login_required, only: %i[new create test_login]
  before_action :logout_required, only: %i[new create]

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: 'I have logged in'
    else
      flash.now[:alert] = 'Your email address or password is incorrect'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: 'logged out'
  end

  def test_login
  session[:user_id] = params[:id]
  cookies.signed[:user_id] = params[:id] if Rails.env.test?
  redirect_to tasks_path
 end
end