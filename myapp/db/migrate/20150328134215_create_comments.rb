class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title, :default => ""
      t.text :comment

      t.references :commentable, :polymorphic => true, index: true
      t.references :user
      t.timestamps
    end
  end
end
