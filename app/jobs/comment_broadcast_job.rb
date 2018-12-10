require 'comment_serializer'

class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform id
    comment = Comment.find(id)
    comment_serialized = CommentSerializer.new(comment).as_json
    ActionCable.server.broadcast(build_room_id(comment_serialized[:geo_cache_id]), comment_serialized)
  end

  def build_room_id geo_cache_id
    "comment_#{geo_cache_id}_channel"
  end
end
