class Question < ActiveRecord::Base
  attr_accessible :description, :note, :parent_id, :question_type, :technology_id, :title, :topic_id, :options_attributes

  has_many :options
  accepts_nested_attributes_for :options, :allow_destroy => true

  QUESTION_TYPE = [["Single answer", "single"], ["Multiple answers", "multiple"], ["Free text", "free_text"]]
end
