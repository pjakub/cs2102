class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :comments
  acts_as_authentic do |c|
  end


end