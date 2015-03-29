class Article < ActiveRecord::Base

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_one :comment, as: :commentable

  PROPERTY_OPTIONS = [['News', 'news'],
                      ['Technology', 'technology'],
                      ['Business', 'business']]

end
