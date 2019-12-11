class User < ApplicationRecord
  ATTRIBUTES_PARAMS = [:name, :email, :password,
    :password_confirmation, :avatar, :birthday, :gender, :role]

  ROLES = %w[admin trainer trainee]

  enum gender: [:female, :male]

  validates :name, presence: true

  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :courses, through: :user_courses, dependent: :destroy
  has_many :subjects, through: :user_subjects, dependent: :destroy

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  scope :superusers, ->{where "role = 'admin' or role = 'trainer'"}
  scope :admins, ->{where "role = 'admin'"}
  scope :trainers, ->{where "role = 'trainer'"}
  scope :trainees, ->{where "role = 'trainee'"}
  scope :order_role, ->{order order_role_by_priority}
  scope :trainee_available_for_course, ->course_id{where QUERY, course_id: course_id}

  QUERY = "id NOT IN (SELECT user_id
    FROM user_courses, courses WHERE user_courses.course_id = courses.id
    AND (courses.status = 0 OR courses.status = 1)
    AND courses.id <> :course_id) AND role = 'trainee'"

  def admin?
    self.role == "admin"
  end

  def trainer?
    self.role == "trainer"
  end

  def trainee?
    self.role == "trainee"
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
