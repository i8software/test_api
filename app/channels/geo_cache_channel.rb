class GeoCacheChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'geo_cache_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
