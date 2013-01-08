class Department < ActiveRecord::Base
  attr_accessible :name
  has_many :users
  validates :name,  :presence => true, :uniqueness => true
  
end
