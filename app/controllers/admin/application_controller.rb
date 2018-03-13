# frozen_string_literal: true

# Main controller
# Implements authorize method for other controllers to use
class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin!

  def index; end

  private

  def authorize_admin!
    authenticate_user!
    return if current_user.admin?
    redirect_to root_path, alert: 'You must be an admin to do that.'
  end
end
