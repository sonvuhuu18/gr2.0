class UserCourse < ApplicationRecord
  include InitUserSubject

  after_create :create_user_subjects_when_assign_new_user

  enum status: [:init, :progress, :finish]

  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  delegate :name, :description, :start_date, :end_date, :status,
    to: :course, prefix: true, allow_nil: true

  scope :find_user_by_role, ->role{joins(:user).where "users.role = ?", role}

  private
  def create_user_subjects_when_assign_new_user
    unless user.role == "trainer"
      create_user_subjects [self], course.subjects, course_id
    end
  end
end
