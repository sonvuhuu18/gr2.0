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
end
