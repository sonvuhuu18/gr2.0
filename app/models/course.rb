class Course < ApplicationRecord
  USER_COURSE_ATTRIBUTES_PARAMS = [user_courses_attributes: [:id, :user_id, :_destroy]]
  COURSE_ATTRIBUTES_PARAMS = [:name, :image, :description, :status,
    :start_date, :end_date]

  enum status: [:init, :progress, :finish]

  validates :name, presence: true

  has_many :subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_courses

  accepts_nested_attributes_for :user_courses, allow_destroy: true
end
