class GeoCacheSerializer < ActiveModel::Serializer
  class CacherSerializer < ActiveModel::Serializer
    attributes :id, :username, :avatar_url
  end

  attributes :id, :lat, :lng, :title, :message, :likes, :unlikes
  belongs_to :cacher, serializer: CacherSerializer
  has_many :comments, serializer: CommentsSerializer

  def likes
    object.likes_count
  end

  def unlikes
    object.unlikes_count
  end
end
