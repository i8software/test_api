class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :commenter, foreign_key: {to_table: :users}, type: :uuid
      t.references :geo_cache, foreign_key: true, type: :uuid
      t.string :comment

      t.timestamps
    end
  end
end
