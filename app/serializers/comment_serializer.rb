class CommentSerializer < ActiveModel::Serializer

  class CommenterSerializer < ActiveModel::Serializer
    attributes :id, :username, :avatar_url
  end

  attributes :id, :comment, :geo_cache_id, :likes, :unlikes
  belongs_to :commenter, serializer: CommenterSerializer
  has_many :replies, serializer: ReplySerializer

  def likes
    object.likes_count
  end

  def unlikes
    object.unlikes_count
  end
end
