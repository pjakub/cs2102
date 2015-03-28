class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  acts_as_authentic do |c|
  end

end