class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject

  validates :number_of_question_in_test, numericality: {greater_than: -1}
end
