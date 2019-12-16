class TestAttemptsController < ApplicationController
  before_action :load_enrollment

  def attempt
    @questions = []
    @enrollment.course.course_subjects.each do |cs|
      @questions += Question.fetch_question(cs.subject.id, cs.number_of_question_in_test)
    end
    @question_ids = @questions.map{|q| q.id}
    @remaining_time = @question_ids.count * 30.seconds
  end

  def get_result
    @question_ids = params[:question_ids].split(" ").map{|id| id}
    @answers = Question.fetch_answer(@question_ids).pluck(:id, :answer).to_h
    @score = 0
    @attempt_answers = params[:attempt_answers]
    if @attempt_answers
      params[:attempt_answers].each do |k,v|
        @score += 1 if @answers[k.to_i] == v.to_i
      end
    end

    @passed = @score >= 0.8*@question_ids.count ? true : false
    @enrollment.update_attributes(test_passed: @passed, last_score: @score)
  end

  private

  def load_enrollment
    return if @enrollment = Enrollment.find_by_id(params[:enrollment_id])
    redirect_back fallback_location: root_path
  end
end
