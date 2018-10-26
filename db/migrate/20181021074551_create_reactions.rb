class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions, id: :uuid do |t|
      t.integer :like
      t.integer :unlike
      t.references :reactor, foreign_key: {to_table: :users}, type: :uuid
      t.references :geo_cache, foreign_key: true, type: :uuid
      t.references :comment, foreign_key: true, type: :uuid
      t.references :reply, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
