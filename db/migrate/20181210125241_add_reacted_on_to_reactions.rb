class AddReactedOnToReactions < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reactions, :geo_cache
    remove_reference :reactions, :comment
    remove_reference :reactions, :reply
    add_reference :reactions, :reacted_on, polymorphic: true, index: true, type: :uuid
    # change_column :reactions, :reacted_on_id, :uuid
  end
end
