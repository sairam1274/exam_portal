module TechnologiesHelper
  def technologies_list
    Technology.all.collect {|technology| [ technology.name, technology.id ]}
  end
end
