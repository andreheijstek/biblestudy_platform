# frozen_string_literal: true

# Controller for Users
# Handling the typical CRUD actions
# :reek:InstanceVariableAssumption - should be no problem here. Default Rails
# behaviour, and covered by :set_user before_action
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # Default index
  def index; end

  # Renders the User registriation form
  def show
    render 'devise/registrations/_form', user: @user
  end

  private

  def set_user
    @user = current_user
  end
end
