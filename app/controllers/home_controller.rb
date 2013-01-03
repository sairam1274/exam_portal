class HomeController < ApplicationController
  def index
    @technologies = Technology.all
  end


  def exam
    @topic = Topic.find_by_id(params[:id])
    respond_to do |format|
      unless @topic.blank?
        format.html
       else
        flash[:notice] = "Oops, we don't have questions on this topic right now.Please try another."
        format.js { render :js => "window.location.replace('#{root_url}');"  }
      end
    end
  end

 def save_exam
   @topic = Topic.find(params[:id])
    respond_to do |format|
      if @topic
        
        flash[:notice] = "Thanks."
        html = root_url
        
        format.js { render :json => { :html => html } }
      else
        #@alerts = @bid.errors
        html = render_to_string(:partial => "home/exam_form")
        format.js { render :json => { :html => html } }
      end
    end
 end

end
