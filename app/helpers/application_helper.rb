module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def technologies_list
    Technology.all.collect {|technology| [ technology.name, technology.id ]}
  end

  def topic_list(technology_id)
    topics = []
    if technology_id
      technology = Technology.find(technology_id)
      topics = technology.topics.all.collect {|topic| [ topic.name, topic.id ]}
    end
    return topics
  end

end
