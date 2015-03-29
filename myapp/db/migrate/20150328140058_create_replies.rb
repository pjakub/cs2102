class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references :article, index: true
      t.references :post, index: true

      t.timestamps null: false
    end
    add_foreign_key :replies, :articles
    add_foreign_key :replies, :posts
  end
end
