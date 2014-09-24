class ApplicationController < ActionController::Base

  def forem_user
    current_user
  end
  helper_method :forem_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'application'
  include SessionsHelper


  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
