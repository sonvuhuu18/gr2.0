class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  before_validation :strip_whitespace

  after_create_commit {MessageBroadcastJob.perform_later self}

  validates :content, presence: true, length: {minimum: 1}

  def strip_whitespace
    # self.content = self.content.strip unless self.content.blank?
    self.content.try &:strip!
  end
end
