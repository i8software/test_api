class GeoCache < ApplicationRecord
  belongs_to :cacher, class_name: 'User', counter_cache: true
  has_many :comments
  has_many :reacted_on
end
