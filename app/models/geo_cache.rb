class GeoCache < ApplicationRecord
  belongs_to :cacher, class_name: 'User', counter_cache: true
  has_many :comments
  has_many :reacted_on

  after_commit do |geo_cache|
    GeoCacheBroadcastJob.perform_later geo_cache.id
  end
end
