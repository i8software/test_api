class ReactionSerializer < ActiveModel::Serializer

  class ReactorSerializer < ActiveModel::Serializer
    attributes :id, :username
  end

  attributes :id, :reaction
  belongs_to :reactor, serializer: ReactorSerializer
end
