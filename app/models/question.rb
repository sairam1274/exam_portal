class Question < ActiveRecord::Base
  attr_accessible :description, :note, :parent_id, :question_type, :technology_id, :title, :topic_id, :options_attributes

  belongs_to :technology
  belongs_to :topic
  has_many :options

  accepts_nested_attributes_for :options, :allow_destroy => true, :reject_if => :all_blank

  belongs_to :topic
  

  QUESTION_TYPE = [["Single answer", "single"], ["Multiple answers", "multiple"], ["Free text", "free_text"]]

  validates :title, :technology_id, :topic_id, :question_type, :presence => true
end
