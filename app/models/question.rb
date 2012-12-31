class Question < ActiveRecord::Base
  attr_accessible :description, :note, :parent_id, :question_type, :technology_id, :title, :topic_id
  accepts_nested_attributes_for :options

  QUESTION_TYPE = ["Single answer", "Multiple answers", "Free text"]
end
