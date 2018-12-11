class GeoCache < ApplicationRecord
  belongs_to :cacher, class_name: 'User', counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :reacted_on, class_name: 'Reaction', foreign_key: "reacted_on_id", dependent: :destroy

  validates :title, length: { minimum: 3, maximum: 150 }, presence: true
  validates :message, length: { minimum: 3, maximum: 500 }, presence: true
  validates :lat, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  after_commit do |geo_cache|
    GeoCacheBroadcastJob.perform_later geo_cache.id
  end
end
