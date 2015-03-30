class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :article, index: true
      t.timestamps null: false
    end
    add_foreign_key :posts, :articles
  end
end
