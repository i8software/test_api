class AddCounterCacheToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :geo_caches_count, :integer, default: 0
    add_column :users, :comments_count, :integer, default: 0
    add_column :users, :replies_count, :integer, default: 0
    add_column :users, :likes_count, :integer, default: 0
    add_column :users, :unlikes_count, :integer, default: 0
    add_column :geo_caches, :comments_count, :integer, default: 0
    add_column :geo_caches, :likes_count, :integer, default: 0
    add_column :geo_caches, :unlikes_count, :integer, default: 0
    add_column :comments, :replies_count, :integer, default: 0
    add_column :comments, :likes_count, :integer, default: 0
    add_column :comments, :unlikes_count, :integer, default: 0
    add_column :replies, :likes_count, :integer, default: 0
    add_column :replies, :unlikes_count, :integer, default: 0
  end
end
