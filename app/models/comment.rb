class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User', counter_cache: true
  belongs_to :geo_cache, counter_cache: true
  has_many :reacted_on, class_name: 'Reaction', foreign_key: "reacted_on_id", dependent: :destroy
  has_many :replies, dependent: :destroy

  validates :comment, length: { minimum: 3, maximum: 250 }, presence: true

  after_commit do |comment|
    CommentBroadcastJob.perform_later comment.id
  end
end
