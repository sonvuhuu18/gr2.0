class Course < ApplicationRecord
  ATTRIBUTES_PARAMS = [:name, :image, :description, :status,
    :start_date, :end_date, user_ids: [],
    course_subjects_attributes: [:id, :course_id, :subject_id, :_destroy]]

  enum status: [:init, :progress, :finish]

  validate :check_end_date, on: [:create, :update]
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  has_many :enrollments, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :users, through: :enrollments, dependent: :destroy
  has_many :subjects, through: :course_subjects, dependent: :destroy

  accepts_nested_attributes_for :course_subjects, allow_destroy: true

  scope :init_courses, ->{where status: :init}
  scope :progress_courses, ->{where status: :progress}
  scope :finish_courses, ->{where status: :finish}

  def check_end_date
    unless self.start_date.nil?
      errors.add :end_date, I18n.t("error.wrong_end_date") if
        self.end_date < self.start_date
    end
  end

  def update_course_and_enrollments status
    self.update_attributes status: status
    enrollments.update_all status: status
  end

  def course_superusers
    users.superusers
  end

  def course_trainees
    users.trainees
  end
end
