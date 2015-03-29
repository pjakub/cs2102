class Article < ActiveRecord::Base

  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_one :comment, as: :commentable
  is_impressionable
  PROPERTY_OPTIONS = {'news' => 'News',
                      'technology'=> 'Technology',
                      'business'=> 'Business'}

end
