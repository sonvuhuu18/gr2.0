class EnrollmentsController < ApplicationController
  load_and_authorize_resource

   def show
    session[:conversations] ||= []
    @users = User.other_users current_user.id
    @conversations = Conversation.includes(:receiver, :messages).find(session[:conversations])
    @course = @enrollment.course
    @trainers = @course.users.trainers
    @trainees = @course.users.trainees
  end
end
