# frozen_string_literal: true

# Main controller
# Implements authorize method for other controllers to use
class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin

  # default index method
  def index; end

  private

  # Authorizes admins for their task. Return message if user is not an admin
  # TODO: This does not really feel like Single Responibility to me, but it's code
  # from a book that I copied, so I leave it like it is for now
  def authorize_admin
    authenticate_user!
    return if current_user.admin?
    redirect_to root_path, alert: 'You must be an admin to do that.'
  end
end
