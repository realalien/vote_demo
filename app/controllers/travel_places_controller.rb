class TravelPlacesController < ApplicationController
  # GET /travel_places
  # GET /travel_places.xml
  def index
    @travel_places = TravelPlace.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @travel_places }
    end
  end

  # GET /travel_places/1
  # GET /travel_places/1.xml
  def show
    @travel_place = TravelPlace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @travel_place }
    end
  end

  # GET /travel_places/new
  # GET /travel_places/new.xml
  def new
    @travel_place = TravelPlace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @travel_place }
    end
  end

  # GET /travel_places/1/edit
  def edit
    @travel_place = TravelPlace.find(params[:id])
  end

  # POST /travel_places
  # POST /travel_places.xml
  def create
    @travel_place = TravelPlace.new(params[:travel_place])

    respond_to do |format|
      if @travel_place.save
        flash[:notice] = 'TravelPlace was successfully created.'
        format.html { redirect_to(@travel_place) }
        format.xml  { render :xml => @travel_place, :status => :created, :location => @travel_place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @travel_place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /travel_places/1
  # PUT /travel_places/1.xml
  def update
    @travel_place = TravelPlace.find(params[:id])

    respond_to do |format|
      if @travel_place.update_attributes(params[:travel_place])
        flash[:notice] = 'TravelPlace was successfully updated.'
        format.html { redirect_to(@travel_place) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @travel_place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /travel_places/1
  # DELETE /travel_places/1.xml
  def destroy
    @travel_place = TravelPlace.find(params[:id])
    @travel_place.destroy

    respond_to do |format|
      format.html { redirect_to(travel_places_url) }
      format.xml  { head :ok }
    end
  end
end
