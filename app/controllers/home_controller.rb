class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
    @technologies = Technology.all
  end


  def exam
    @topic = Topic.find_by_id(params[:id])
    respond_to do |format|
      unless @topic.blank?
        unless @topic.questions.blank?
          @exam = Exam.create(:topic_id=>@topic.id,:technology_id=>@topic.technology_id,:user_id=>current_user.id,:start_time=>Time.now)
        end
        format.html
      else
        flash[:notice] = "Oops, we don't have questions on this topic right now.Please try another."
        format.js { render :js => "window.location.replace('#{root_url}');"  }
      end
    end
    
  end

  def save_exam
    @topic = Topic.find(params[:id])
    if @topic
      @exam = Exam.find_by_id(params[:answer][:exam_id])
      unless @topic.questions.blank?
        @topic.questions.each_with_index do |question,i|
          @answer = Answer.first(:conditions => {:exam_id => @exam.id, :topic_id =>@topic.id, :question_id => question.id})
          if @answer.blank?
            @answer = Answer.new()
            @answer.exam_id = @exam.id
            @answer.question_id = question.id
            @answer.question_title = question.title
            @answer.topic_id = @topic.id
            @answer.technology_id = @topic.technology_id
            @answer.user_id = current_user.id
            @answer.question_type = question.question_type
            @answer_ids = params[:answer]["#{question.id}"].collect{|c| c} unless params[:answer]["#{question.id}"].blank?
            if question.question_type == "single"
              @answer.actual_answer_ids = question.options.collect{|c| c.id if c.correct_answer == true}.compact.join(',') unless question.options.blank?
              @answer.given_answer_ids = @answer_ids.join(',') unless params[:answer]["#{question.id}"].blank?
              @answer.actual_answers = question.options.collect{|c| c.answer} unless question.options.blank?
              unless @answer_ids.blank?
                @answers = []
                @answer_ids.each do |answer_id|
                  @answers << Option.first(:conditions => {:id =>answer_id.to_i, :question_id => question.id}).answer
                end
              end
              @answer.given_answers =  @answers.compact unless @answers.blank?

            elsif question.question_type == "multiple"
              @answer.actual_answer_ids = question.options.collect{|c| c.id if c.correct_answer == true}.compact.join(',') unless question.options.blank?
              @answer.given_answer_ids = @answer_ids.join(',') unless params[:answer]["#{question.id}"].blank?
              @answer.actual_answers = question.options.collect{|c| c.answer} unless question.options.blank?
              unless @answer_ids.blank?
                @answers = []
                @answer_ids.each do |answer_id|
                  @answers << Option.first(:conditions => {:id =>answer_id.to_i, :question_id => question.id}).answer
                end
              end
              @answer.given_answers =  @answers.compact unless @answers.blank?

            elsif question.question_type == "free_text"
              #@answer.given_answers =  params[:answer]["#{question.id}"] unless params[:answer]["#{question.id}"].blank?
              @answer.free_text_answer =  params[:answer]["#{question.id}"] unless params[:answer]["#{question.id}"].blank?

            end
            @answer.save!
          end
          if @answer.question_type != "free_text"
            unless @answer.given_answer_ids.blank?
              if @answer.given_answer_ids == @answer.actual_answer_ids
                @answer.update_attributes(:is_correct=>true)
              end
            end
          end
        end
        @exam.update_attributes(:end_time=>Time.now)
        @multiple_choice_questions = @exam.answers.where(['question_type <> ?', "free_text"]).length
        if @multiple_choice_questions > 0
          @correct_multiple_choice_questions = @exam.answers.where(['is_correct =? and question_type <> ?',true, "free_text"]).length
        end
        @free_text_questions = @exam.answers.where(['question_type = ?', "free_text"]).length
      end
      if (@multiple_choice_questions > 0 and @free_text_questions > 0)
         
        flash[:notice] = "Thanks.You got #{@correct_multiple_choice_questions} out of #{@multiple_choice_questions} questions right for other #{@free_text_questions} - we shall update you in 2 days and add it to your final score."
      elsif (@multiple_choice_questions == 0 and @free_text_questions > 0)
          
        flash[:notice] = "Thanks. For #{@free_text_questions} text question - we shall update you in 2 days and add it is your final score."
      elsif (@multiple_choice_questions > 0 and @free_text_questions == 0)
          
        @exam.update_attributes(:is_completed=>true)
        flash[:notice] = "Thanks.You got #{@correct_multiple_choice_questions} out of #{@multiple_choice_questions} questions right and it is your final score."
      end
      Notifier.exam_submit_mail(@exam,current_user).deliver
      redirect_to show_reports_url(@exam.id)
    else
      flash[:notice] = "Oops, we don't have questions on this topic right now.Please try another."
      redirect_to root_url
    end
   
  end


  def check_free_text_answers
    @exam = Exam.find_by_id(params[:id])
    #respond_to do |format|
      if @exam
        @free_text_answers = @exam.answers.where(['question_type = ?', "free_text"])
        unless @free_text_answers.blank?
          @free_text_answers.each do |answer|
            unless params[:answer]["is_correct_#{answer.id}"].blank?
              if params[:answer]["is_correct_#{answer.id}"] == "true"
                answer.update_attributes(:is_correct=>true)
              else
                answer.update_attributes(:is_correct=>false)
              end
            else
              answer.update_attributes(:is_correct=>false)
            end
          end
        end
        unless params[:exam].blank?
          unless params[:exam][:is_completed].blank?
            if params[:exam][:is_completed] == "true"
              @exam.update_attributes(:is_completed=>true)
            else
              @exam.update_attributes(:is_completed=>false)
            end
          else
            @exam.update_attributes(:is_completed=>false)
          end
        else
          @exam.update_attributes(:is_completed=>false)
        end
        if @exam.is_completed == true
          @correct_answers = @exam.answers.where(['is_correct = ?', true]).length
          @exam.update_attributes(:marks=>@correct_answers)
        end
        flash[:notice] = "Exam updated successfully."
        redirect_to reports_url
       # format.js { render :js => "window.location.replace('#{reports_url}');" }
      else
        flash[:notice] = "We don't have report for this exam right now."
        redirect_to reports_url


        #format.js { render :js => "window.location.replace('#{reports_url}');" }
      end
    #end
  end

end
