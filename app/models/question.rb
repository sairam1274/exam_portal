class Question < ActiveRecord::Base
  attr_accessible :description, :note, :parent_id, :question_type, :technology_id, :title, :topic_id
end
