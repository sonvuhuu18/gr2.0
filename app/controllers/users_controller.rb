class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def edit
  end

  def update
    if user_params[:password].present?
      if @user.update_attributes user_params
        sign_in @user, bypass: true
        flash[:success] = t "flash.update_success"
        redirect_to edit_user_path @user
      else
        flash[:danger] = t "flash.update_fail"
        render :edit
      end
    else
      if @user.update_without_password user_params
        flash[:success] = t "flash.update_success"
        redirect_to edit_user_path @user
      else
        flash[:danger] = t "flash.update_fail"
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit :avatar, :password, :password_confirmation
  end
end
