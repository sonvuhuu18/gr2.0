class User < ApplicationRecord
  ATTRIBUTES_PARAMS = [:name, :email, :password,
    :password_confirmation, :avatar, :avatar_cache, :birthday, :gender, :role]

  ROLES = %w[admin trainer trainee]
  ASSIGN_ROLES = %w[trainee trainer]

  mount_uploader :avatar, ImageUploader

  enum gender: [:female, :male]

  validate :check_birthday, on: [:create, :update]
  validates :name, presence: true

  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id
  has_many :messages, dependent: :destroy

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  scope :other_users, ->current_user_id{where.not id: current_user_id}
  scope :superusers, ->{where "role = 'admin' or role = 'trainer'"}
  scope :admins, ->{where "role = 'admin'"}
  scope :trainers, ->{where "role = 'trainer'"}
  scope :trainees, ->{where "role = 'trainee'"}
  scope :order_role, ->{order order_role_by_priority}
  scope :trainee_available_for_course, ->course_id{where QUERY, course_id: course_id}

  QUERY = "id NOT IN (SELECT user_id
    FROM enrollments, courses WHERE enrollments.course_id = courses.id
    AND (enrollments.status = 0 OR enrollments.status = 1)
    AND courses.id <> :course_id) AND role = 'trainee'"

  def check_birthday
    unless self.birthday.nil?
      errors.add :birthday, I18n.t("error.wrong_birthday") if
        self.birthday > (Date.today - 18.year)
    end
  end

  def admin?
    self.role == "admin"
  end

  def trainer?
    self.role == "trainer"
  end

  def trainee?
    self.role == "trainee"
  end

  def enrollments_active
    enrollments.active_trainee_courses.reverse
  end

  class << self
    def order_role_by_priority
      ret = "CASE"
      ROLES.each_with_index do |p, i|
        ret << " WHEN role = '#{p}' THEN #{i}"
      end
      ret << " END"
    end
  end
end
