class Feedback < ApplicationRecord
  ATTRIBUTES_PARAMS = [:user_id, :title, :content, :status]

  enum status: ["pending", "in_progress", "under_consideration", "implemented", "rejected"]

  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  default_scope ->{order created_at: :desc}
end
