class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :comments

  acts_as_authentic
  acts_as_liker


end