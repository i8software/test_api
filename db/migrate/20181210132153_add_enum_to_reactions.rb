class AddEnumToReactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :reactions, :like
    remove_column :reactions, :unlike
    add_column :reactions, :reaction, :integer
  end
end
