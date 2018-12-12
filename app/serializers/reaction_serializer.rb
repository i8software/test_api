class ReactionSerializer < ActiveModel::Serializer

  class ReactorSerializer < ActiveModel::Serializer
    attributes :id, :username, :avatar_url
  end

  attributes :id, :reaction
  belongs_to :reactor, serializer: ReactorSerializer
end
