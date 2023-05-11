# frozen_string_literal: true

# Admin class for Admin users
module Admin
  class ApplicationController < ApplicationController
    before_action :authorize_admin

    # default index method
    def index; end

    private

    # Authorizes admins for their task. Return message if user is not an admin
    def authorize_admin
      authenticate_user!
      return if current_user.admin?

      redirect_to root_path, alert: 'You must be an admin to do that.'
    end
  end
end
