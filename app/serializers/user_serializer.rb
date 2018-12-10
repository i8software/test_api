class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :first_name, :last_name, :geo_caches, :comments, :replies, :reactions

  def geo_caches
    object.geo_caches_count
  end

  def comments
    object.comments_count
  end

  def replies
    object.replies_count
  end

  def reactions
    object.likes_count + object.unlikes_count
  end
end
