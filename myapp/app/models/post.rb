class Post < ActiveRecord::Base
  belongs_to :article
  has_one :comment, as: :commentable

  has_many :replies, dependent: :destroy

end
