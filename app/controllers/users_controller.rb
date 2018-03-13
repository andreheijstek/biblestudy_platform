# frozen_string_literal: true

# Controller for Users
# Handling the typical CRUD actions
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index; end

  def show
    render 'devise/registrations/_form', user: @user
  end

  private

  def set_user
    @user = current_user
  end
end
