# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def set_locale
    lo = params[:locale] || session[:locale] || I18n.default_locale
    lo = lo.to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(lo) ? lo : I18n.default_locale
    session[:locale] = I18n.locale
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "login_pls"
    redirect_to login_url
  end
end
