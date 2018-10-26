class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User', counter_cache: true
  belongs_to :geocache, counter_cache: true
end
