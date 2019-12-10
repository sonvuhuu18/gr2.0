class Subject < ApplicationRecord
  ATTRIBUTES_PARAMS = [:identifier, :description, :course_id]

  validates :identifier, presence: true

  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  delegate :name, to: :course, prefix: true, allow_nil: true
end
