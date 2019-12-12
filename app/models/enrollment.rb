class Enrollment < ApplicationRecord
  enum status: [:init, :progress, :finish]

  belongs_to :user
  belongs_to :course

  delegate :name, :description, :start_date, :end_date, :status,
    to: :course, prefix: true, allow_nil: true

  scope :find_user_by_role, ->role{joins(:user).where "users.role = ?", role}
end
