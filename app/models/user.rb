class User < ApplicationRecord
  ATTRIBUTES_PARAMS = [:name, :email, :password,
    :password_confirmation, :avatar, :birthday, :gender, :role]

  ROLES = %w[admin trainer trainee]

  enum gender: [:female, :male]

  validates :name, presence: true

  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :courses, through: :user_subjects
  has_many :subjects, through: :user_subjects

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  scope :superuser, ->{where "role = 'admin' or role = 'trainer'"}
  scope :order_role, ->{order order_role_by_priority}

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
