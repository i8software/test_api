require 'geo_cache_serializer'

class GeoCacheBroadcastJob < ApplicationJob
  queue_as :default

  def perform id
    geo_cache = GeoCache.find(id)
    geo_cache_serialized = GeoCacheSerializer.new(geo_cache).as_json
    ActionCable.server.broadcast('geo_cache_channel', geo_cache_serialized)
  end
end
