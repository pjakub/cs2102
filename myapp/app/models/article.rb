class Article < ActiveRecord::Base
  belongs_to :user
  PROPERTY_OPTIONS = [['News', 'news'],
                      ['Technology', 'technology'],
                      ['Business', 'business']]
  validates :title, presence: true,
                    length: { minimum: 5 }
end
