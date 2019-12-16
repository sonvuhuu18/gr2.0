class Choice < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :choice_number, presence: true, uniqueness: {scope: :question_id}
end
