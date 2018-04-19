# frozen_string_literal: true

module Admin
  # Controller for Users
  # Handling the typical CRUD actions
  class UsersController < Admin::ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    attr_reader :user

    def index
      users = User.order(:email)
      locals users: users
    end

    def show
      locals user: user
    end

    def new
      user = User.new
      locals user: user
    end

    def create
      user       = User.new(user_params)
      user.admin = params[:user][:admin] if current_user.admin?
      save_user(user)
    end

    def edit
      locals user: user
    end

    def update
      user = params[:user]
      user.delete(:password) if user[:password].blank?
      update_user
    end

    private

    def save_user(user)
      if user.save
        flash[:notice] = t('activerecord.messages.created')
        redirect_to admin_users_path
      else
        flash.now[:alert] = t('activerecord.messages.notcreated')
        locals :new, user: user
      end
    end

    def update_user
      if @user.update(user_params)
        set_admin
        flash[:notice] = t('activerecord.attributes.user.messages.updated')
        redirect_to admin_users_path
      else
        flash.now[:alert] =
          t('activerecord.attributes.user.messages.notupdated')
        locals :edit, user: user
      end
    end

    def set_admin
      return unless current_user.admin?
      @user.admin = params[:user][:admin]
      @user.save
    end

    def user_params
      params.require(:user).permit(:email, :password, :username)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
