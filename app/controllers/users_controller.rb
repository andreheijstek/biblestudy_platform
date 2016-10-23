class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    render 'devise/registrations/_form', user: @user
  end

  private

  def set_user
    @user = current_user
  end
end
