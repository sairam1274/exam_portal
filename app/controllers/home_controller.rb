class HomeController < ApplicationController
  def index
    @technologies = Technology.all
  end
end
