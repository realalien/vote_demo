class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.xml
  def index
    @teams = Teams.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @teams = Teams.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @teams = Teams.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1/edit
  def edit
    @teams = Teams.find(params[:id])
  end

  # POST /teams
  # POST /teams.xml
  def create
    @teams = Teams.new(params[:teams])

    respond_to do |format|
      if @teams.save
        flash[:notice] = 'Teams was successfully created.'
        format.html { redirect_to(@teams) }
        format.xml  { render :xml => @teams, :status => :created, :location => @teams }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @teams.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    @teams = Teams.find(params[:id])

    respond_to do |format|
      if @teams.update_attributes(params[:teams])
        flash[:notice] = 'Teams was successfully updated.'
        format.html { redirect_to(@teams) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @teams.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @teams = Teams.find(params[:id])
    @teams.destroy

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end
end
