class TeamsController < ApplicationController
  
  # Notes: 
  #  * Because it's not like desired ajax page, almost the same as normal
  #    scaffold, the active scaffold is not in use. 
  active_scaffold :team do |config|

    config.label = "Teams"
    config.columns = [:name, :description ]
    #list.columns.exclude :comments
    list.sorting = {:name => 'ASC'}
    #columns[:phone].label = "Phone #"
    #columns[:phone].description = "(Format: ###-###-####)"
  end
  
#  # GET /teams
#  # GET /teams.xml
#  def index
#    @teams = Team.find(:all)
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @teams }
#    end
#  end
#
#  # GET /teams/1
#  # GET /teams/1.xml
#  def show
#    @team = Team.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @team }
#    end
#  end
#
#  # GET /teams/new
#  # GET /teams/new.xml
#  def new
#    @team = Team.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @team }
#    end
#  end
#
#  # GET /teams/1/edit
#  def edit
#    @team = Team.find(params[:id])
#  end
#
#  # POST /teams
#  # POST /teams.xml
#  def create
#    @team = Team.new(params[:team])
#
#    respond_to do |format|
#      if @team.save
#        flash[:notice] = 'Team was successfully created.'
#        format.html { redirect_to(@team) }
#        format.xml  { render :xml => @team, :status => :created, :location => @team }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /teams/1
#  # PUT /teams/1.xml
#  def update
#    @team = Team.find(params[:id])
#
#    respond_to do |format|
#      if @team.update_attributes(params[:teams])
#        flash[:notice] = 'Team was successfully updated.'
#        format.html { redirect_to(@team) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /teams/1
#  # DELETE /teams/1.xml
#  def destroy
#    @team = Team.find(params[:id])
#    @team.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(teams_url) }
#      format.xml  { head :ok }
#    end
#  end
end
