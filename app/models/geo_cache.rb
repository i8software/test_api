class GeoCache < ApplicationRecord
  belongs_to :cacher, class_name: 'User', counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :reacted_on, class_name: 'Reaction', foreign_key: "reacted_on_id", dependent: :destroy

  after_commit do |geo_cache|
    GeoCacheBroadcastJob.perform_later geo_cache.id
  end
end
