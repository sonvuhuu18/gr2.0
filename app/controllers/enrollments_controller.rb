class EnrollmentsController < ApplicationController
  load_and_authorize_resource

   def show
    session[:conversations] ||= []
    @users = User.other_users current_user.id
    @conversations = Conversation.includes(:receiver, :messages).find(session[:conversations])
    @course = @enrollment.course
    @trainers = @course.users.trainers
    @trainees = @course.users.trainees
    @number_of_questions_in_test = 0
    @enrollment.course.course_subjects.each do |cs|
      @number_of_questions_in_test += cs.number_of_question_in_test
    end
  end
end
