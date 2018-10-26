class Reaction < ApplicationRecord
  belongs_to :reactor, class_name: 'User', counter_cache: true
  belongs_to :geocache, counter_cache: true
  belongs_to :comment, counter_cache: true
  belongs_to :reply, counter_cache: true
end
