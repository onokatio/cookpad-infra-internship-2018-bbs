class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  before_action :increment_counter

  def increment_counter
    BBS::Counter.increment
  end

  def current_user=(u)
    session[:current_user_id] = u.id
  end

  def current_user
    unless session[:current_user_id]
      return nil
    end

    User.find(session[:current_user_id])
  end
  helper_method :current_user
end
