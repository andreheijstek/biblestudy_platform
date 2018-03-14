# frozen_string_literal: true

module Admin
  # Controller for Users
  # Handling the typical CRUD actions
  class UsersController < Admin::ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @users = User.order(:email)
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:notice] = t('activerecord.messages.created')
        redirect_to admin_users_path
      else
        flash.now[:alert] = t('activerecord.messages.notcreated')
        render 'new'
      end
    end

    def edit; end

    def update
      params[:user].delete(:password) if params[:user][:password].blank?
      update_user
    end

    private

    def update_user
      if @user.update(user_params)
        flash[:notice] = t('activerecord.attributes.user.messages.updated')
        redirect_to admin_users_path
      else
        flash.now[:alert] =
          t('activerecord.attributes.user.messages.notupdated')
        render 'edit'
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :admin, :username)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
