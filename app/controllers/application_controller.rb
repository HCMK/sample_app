# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def set_locale
    lo = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(lo) ? lo : I18n.default_locale
  end
end
