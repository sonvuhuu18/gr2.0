class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user_courses = @user.user_courses
    @inprogress_course = @user_courses.progress_user_courses.last
    @finished_courses = @user_courses.finish_user_courses
  end

  def edit
  end

  def update
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      if @user.update_without_password user_params_without_password
        flash[:success] = t "flash.update_success"
        redirect_to edit_user_path @user
      else
        flash[:danger] = t "flash.update_fail"
        render :edit
      end
    else
      if @user.update_with_password user_params
        sign_in @user, bypass: true
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
    params.require(:user).permit :avatar, :avatar_cache, :remove_avatar,
      :password, :password_confirmation, :current_password
  end

  def user_params_without_password
    params.require(:user).permit :avatar, :avatar_cache, :remove_avatar
  end
end
