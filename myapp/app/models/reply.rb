class Reply < ActiveRecord::Base
  belongs_to :article
  belongs_to :post
  has_one :comment, as: :commentable

end
