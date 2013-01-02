class Technology < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :topics
  has_many :questions

  validates :name, :presence => true, :uniqueness => :true
end
