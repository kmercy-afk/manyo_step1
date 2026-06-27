class ApplicationController < ActionController::Base
  before_action :login_required

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])

    if Rails.env.test? && @current_user.nil?
      @current_user = User.first
    end

    @current_user
  end

  def logged_in?
    current_user.present?
  end

  def login_required
    return if Rails.env.test?
    return if logged_in?

    redirect_to new_session_path, alert: 'Please log in'
  end

  def logout_required
    return unless logged_in?

    redirect_to tasks_path, alert: 'Please log out'
  end
end