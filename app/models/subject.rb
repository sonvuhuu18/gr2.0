class Subject < ApplicationRecord
  ATTRIBUTES_PARAMS = [:name, :image, :image_cache, :description]

  mount_uploader :image, ImageUploader

  validates :name, presence: true

  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects, dependent: :destroy

  def subject_superusers
    users.superusers
  end
end
