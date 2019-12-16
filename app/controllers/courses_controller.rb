class CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :load_course, only: [:show, :index]

  def index
    session[:conversations] ||= []
    @users = User.other_users current_user.id
    @conversations = Conversation.includes(:receiver, :messages).find(session[:conversations])
  end

  def show
  end

  private
  def load_course
    @enrollments = current_user.enrollments_active
    @course_active_last = @enrollments.last
  end
end
