class QuestionsController < ApplicationController

  before_filter :get_survey
	
  # GET /questions
  # GET /questions.xml
  def index
	@survey = Survey.find(params[:survey_id])
    @questions = @survey.questions #Question.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id]) # This is not necessary! #@survey = Survey.find(params[:survey_id]) 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
	@survey = Survey.find(params[:survey_id])
    @question = Question.new(params[:question])
	@survey.questions << @question
    respond_to do |format|
      if @survey.save #@question.save
        flash[:notice] = 'Question was successfully created into a survey.'
        format.html { redirect_to(@survey, @question) }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to(@survey,@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end

  def get_survey
	   @survey = Survey.find(params[:id])
  end
  
  # for each user
  def rate
    @question = Question.find(params[:id])
    @question.rate(params[:stars], current_user, params[:dimension])
    
    # update the responses table to make it archievale/versionable?
    response = Response.find(:first, :conditions => [ "user_id = :user_id and question_id = :question_id" , { :user_id=> current_user.id, :question_id => @question.id } ])
    response.rating = params[:stars]
    response.save!
    
    render :update do |page|
      logger.info "----------------------------------"
      logger.info "#{@question.wrapper_dom_id(params)}"
      logger.info "----------------------------------"
      logger.info "#{ratings_for(@question, params.merge(:wrap => false))}"
      logger.info "----------------------------------"
      logger.info params
      logger.info "----------------------------------"
      # try to remove the heading underline to test if the id caused the RJS update error.
      if @question.wrapper_dom_id(params)[0] == "_"
        idd = @question.wrapper_dom_id(params).slice(1,@question.wrapper_dom_id(params).size)
      else
        idd = @question.wrapper_dom_id(params)
      end
      page.replace_html idd, ratings_for(@question, params.merge(:wrap => false))
      page.visual_effect :highlight, idd
    end
  end
  
  
end
