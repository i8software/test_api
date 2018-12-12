class ReplySerializer < ActiveModel::Serializer

  class SenderSerializer < ActiveModel::Serializer
    attributes :id, :username, :avatar_url
  end

  attributes :id, :comment_id, :reply, :likes, :unlikes
  belongs_to :sender, serializer: SenderSerializer

  def likes
    object.likes_count
  end

  def unlikes
    object.unlikes_count
  end
end
