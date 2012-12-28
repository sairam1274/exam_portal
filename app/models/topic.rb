class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :technology_id
  belongs_to :technology

  validates :technology_id, :presence => true
  validates :name, :presence => true, :uniqueness => :true
  
end
