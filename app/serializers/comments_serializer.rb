class CommentsSerializer < ActiveModel::Serializer

  class CommenterSerializer < ActiveModel::Serializer
    attributes :id, :username, :avatar_url
  end

  attributes :id, :comment, :geo_cache_id, :likes, :unlikes, :replies
  belongs_to :commenter, serializer: CommenterSerializer

  def likes
    object.likes_count
  end

  def unlikes
    object.unlikes_count
  end

  def replies
    object.replies_count
  end
end
