class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies, id: :uuid do |t|
      t.references :comment, foreign_key: true, type: :uuid
      t.string :reply
      t.references :sender, foreign_key: {to_table: :users}, type: :uuid

      t.timestamps
    end
  end
end
