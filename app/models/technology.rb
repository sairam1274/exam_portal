class Technology < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :topics

  validates :name, :presence => true, :uniqueness => :true
end
