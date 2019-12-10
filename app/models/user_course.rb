class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  delegate :name, :description, :start_date, :end_date, :status,
    to: :course, prefix: true, allow_nil: true
end
