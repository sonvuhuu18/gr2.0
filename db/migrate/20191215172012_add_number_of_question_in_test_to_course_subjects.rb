class AddNumberOfQuestionInTestToCourseSubjects < ActiveRecord::Migration[5.2]
  def change
    add_column :course_subjects, :number_of_question_in_test, :integer, default: 0
  end
end
