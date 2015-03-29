class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  acts_as_likeable
end
