class Subject < ApplicationRecord
  ATTRIBUTES_PARAMS = [:name, :description]

  validates :name, presence: true

  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects, dependent: :destroy
end
