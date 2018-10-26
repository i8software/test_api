class GeoCache < ApplicationRecord
  belongs_to :cacher, class_name: 'User', counter_cache: true
end
