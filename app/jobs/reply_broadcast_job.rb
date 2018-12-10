require 'reply_serializer'

class ReplyBroadcastJob < ApplicationJob
  queue_as :default

  def perform id
    reply = Reply.find(id)
    reply_serialized = ReplySerializer.new(reply).as_json
    ActionCable.server.broadcast(build_room_id(reply_serialized[:comment_id]), reply_serialized)
  end

  def build_room_id comment_id
    "reply_#{comment_id}_channel"
  end
end
