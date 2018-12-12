class GeoCachesSerializer < ActiveModel::Serializer

  class CacherSerializer < ActiveModel::Serializer
    attributes :id, :username, :avatar_url
  end

  attributes :id, :lat, :lng, :title, :message, :likes, :unlikes, :comments
  belongs_to :cacher, serializer: CacherSerializer

  def likes
    object.likes_count
  end

  def unlikes
    object.unlikes_count
  end

  def comments
    object.comments_count
  end
end
