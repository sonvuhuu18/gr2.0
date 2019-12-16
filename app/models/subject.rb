class Subject < ApplicationRecord
  ATTRIBUTES_PARAMS = [:name, :image, :image_cache, :description,
    questions_attributes: [:id, :content, :answer, :_destroy,
      choices_attributes: [:id, :content, :choice_number, :_destroy]]]

  mount_uploader :image, ImageUploader

  validates :name, presence: true

  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects, dependent: :destroy
  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions, allow_destroy: true

  def subject_superusers
    users.superusers
  end
end
