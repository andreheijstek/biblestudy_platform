# frozen_string_literal: true

# Main Controller
# Security and localization concerns
class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  # Sets the locale so the right language is displayed
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protected

  # Sets permissions
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  # These groups are equivalent:
  #
  #   render action: :new, locals: { item: x }
  #   render :new, locals: { item: x }
  #   locals :new, item: x
  #
  #   render locals: { item: x }
  #   locals item: x
  #
  # rubocop: disable Style/OptionalArguments
  def locals(action = nil, hash)
    render action: action, locals: hash
  end

  # rubocop: enable Style/OptionalArguments

  private

  def not_authorized
    redirect_to root_path, alert: t('not_allowed')
  end
end
