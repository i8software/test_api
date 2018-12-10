class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User', counter_cache: true
  belongs_to :geo_cache, counter_cache: true
  has_one :reacted_on
end
