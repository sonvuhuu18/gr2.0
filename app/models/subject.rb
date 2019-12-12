class Subject < ApplicationRecord
  ATTRIBUTES_PARAMS = [:identifier, :description]

  validates :identifier, presence: true

  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects, dependent: :destroy

end
