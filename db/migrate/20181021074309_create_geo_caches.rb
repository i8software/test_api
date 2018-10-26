class CreateGeoCaches < ActiveRecord::Migration[5.2]
  def change
    create_table :geo_caches, id: :uuid do |t|
      t.references :cacher, foreign_key: {to_table: :users}, type: :uuid
      t.string :message
      t.string :title
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6

      t.timestamps
    end
  end
end
