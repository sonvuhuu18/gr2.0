class Question < ApplicationRecord
  belongs_to :subject
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true

  validates :content, presence: true
  validates :answer, presence: true

  class << self
    def fetch_question subject_id, count
      where(subject_id: subject_id)
      .order("RANDOM()").limit(count)
    end

    def fetch_answer ids
      where("questions.id IN (?)", ids)
    end
  end
end
