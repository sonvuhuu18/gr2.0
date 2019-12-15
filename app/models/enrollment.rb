class Enrollment < ApplicationRecord
  enum status: [:init, :progress, :finish]

  belongs_to :user
  belongs_to :course

  delegate :code, :name, :description, :content, :start_date, :end_date, :status,
    to: :course, prefix: true, allow_nil: true

  scope :find_user_by_role, ->role{joins(:user).where "users.role = ?", role}
  scope :all_trainee_courses, ->{joins(:user).where "users.role = 'trainee'"}
  scope :init_enrollments, ->{where status: :init}
  scope :progress_enrollments, ->{where status: :progress}
  scope :finish_enrollments, ->{where status: :finish}
  scope :active_trainee_courses, ->{joins(:user).where QUERY}
  QUERY = "users.role = 'trainee' AND (status = 0 OR status = 1)"
end
