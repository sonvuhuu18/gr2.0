class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :user_course
  belongs_to :subject
  belongs_to :course

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :identifier, :description, to: :subject, prefix: true, allow_nil: true
  delegate :name, to: :course, prefix: true, allow_nil: true
end
