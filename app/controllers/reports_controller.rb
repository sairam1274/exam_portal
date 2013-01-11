class ReportsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin_user, :only => [:index]
   
  def index
    @exams = Kaminari.paginate_array(Exam.where(["end_time is NOT NULL"]).order("created_at desc")).page(params[:page]).per(9)
  end


  def show
    if current_user.has_role?("admin")
      @exam = Exam.first(:conditions => {:id => params[:id]})
    else
      @exam = Exam.first(:conditions => {:id => params[:id], :user_id => current_user.id})
    end
    unless @exam.blank?
      @topic = Topic.find_by_id(@exam.topic_id)
    else
      flash[:notice] = "We don't have report for this exam right now."
      redirect_to root_url
    end
  end

  def my_reports
     @exams = Kaminari.paginate_array(Exam.where(["end_time is NOT NULL and user_id =?",current_user.id]).order("created_at desc")).page(params[:page]).per(9)
     render :action => "index"
  end

   def search
    if params[:title].blank? && params[:is_completed].blank? && params[:free_text_answer].blank?
       @exams = Kaminari.paginate_array(Exam.where(["end_time is NOT NULL"]).order("created_at desc")).page(params[:page]).per(9)
    elsif params[:title].blank? && params[:is_completed].present? && params[:free_text_answer].present?
       @exams = Kaminari.paginate_array(Exam.includes(:user,:answers).where("`answers`.`question_type` =? and exams.is_completed =?", "free_text", true).where(["exams.end_time is NOT NULL"]).uniq).page(params[:page]).per(9)
    elsif params[:title].present? && params[:is_completed].present? && params[:free_text_answer].blank?
       title = "%"+params[:title]+"%"
       @exams = Kaminari.paginate_array(Exam.includes(:user,:answers).where("`answers`.`question_title` like ? or `exams`.`topic` like? or `exams`.`technology` like? or `users`.`name` like ?", title,title,title, title).where(["end_time is NOT NULL"]).where("exams.is_completed =?", true).where(["end_time is NOT NULL"]).uniq).page(params[:page]).per(9)
    elsif params[:title].present? && params[:is_completed].blank? && params[:free_text_answer].present?
       title = "%"+params[:title]+"%"
       @exams = Kaminari.paginate_array(Exam.includes(:user,:answers).where("`answers`.`question_title` like ? or `exams`.`topic` like? or `exams`.`technology` like? or `users`.`name` like ?", title,title,title, title).where("`answers`.`question_type`  =?","free_text").where(["end_time is NOT NULL"]).uniq).page(params[:page]).per(9)
   elsif params[:title].blank? && params[:is_completed].blank? && params[:free_text_answer].present?
       @exams = Kaminari.paginate_array(Exam.includes(:user,:answers).where("`answers`.`question_type` =?", "free_text").where(["end_time is NOT NULL"]).uniq).page(params[:page]).per(9)
    elsif params[:title].present? && params[:is_completed].blank? && params[:free_text_answer].blank?
        title = "%"+params[:title]+"%"
       @exams = Kaminari.paginate_array(Exam.includes(:user,:answers).where("`answers`.`question_title` like ? or `exams`.`topic` like? or `exams`.`technology` like? or `users`.`name` like ?", title,title,title, title).where(["end_time is NOT NULL"]).uniq).page(params[:page]).per(9)
    elsif params[:title].present? && params[:is_completed].blank? && params[:free_text_answer].present?
      @exams = Kaminari.paginate_array(Exam.includes(:user,:answers).where("`answers`.`question_type`  =?","free_text").where(["end_time is NOT NULL"]).uniq).page(params[:page]).per(9)
    else
      title = "%"+params[:title]+"%"
      @exams = Kaminari.paginate_array(Exam.includes(:user,:answers).where("`answers`.`question_title` like ? or `exams`.`topic` like? or `exams`.`technology` like? or `users`.`name` like ?", title,title,title, title).where(["end_time is NOT NULL"]).uniq).page(params[:page]).per(9)
    end
    render :action => "index"
  end

end
