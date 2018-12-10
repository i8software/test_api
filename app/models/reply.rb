class Reply < ApplicationRecord
  belongs_to :comment, counter_cache: true
  belongs_to :sender, class_name: 'User', counter_cache: true
  has_one :reacted_on
end
