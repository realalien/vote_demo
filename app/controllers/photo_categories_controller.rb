class PhotoCategoriesController < ApplicationController
  # GET /photo_categories
  # GET /photo_categories.xml
  def index
    @photo_categories = PhotoCategories.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photo_categories }
    end
  end

  # GET /photo_categories/1
  # GET /photo_categories/1.xml
  def show
    @photo_categories = PhotoCategories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo_categories }
    end
  end

  # GET /photo_categories/new
  # GET /photo_categories/new.xml
  def new
    @photo_categories = PhotoCategories.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo_categories }
    end
  end

  # GET /photo_categories/1/edit
  def edit
    @photo_categories = PhotoCategories.find(params[:id])
  end

  # POST /photo_categories
  # POST /photo_categories.xml
  def create
    @photo_categories = PhotoCategories.new(params[:photo_categories])

    respond_to do |format|
      if @photo_categories.save
        flash[:notice] = 'PhotoCategories was successfully created.'
        format.html { redirect_to(@photo_categories) }
        format.xml  { render :xml => @photo_categories, :status => :created, :location => @photo_categories }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo_categories.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photo_categories/1
  # PUT /photo_categories/1.xml
  def update
    @photo_categories = PhotoCategories.find(params[:id])

    respond_to do |format|
      if @photo_categories.update_attributes(params[:photo_categories])
        flash[:notice] = 'PhotoCategories was successfully updated.'
        format.html { redirect_to(@photo_categories) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo_categories.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photo_categories/1
  # DELETE /photo_categories/1.xml
  def destroy
    @photo_categories = PhotoCategories.find(params[:id])
    @photo_categories.destroy

    respond_to do |format|
      format.html { redirect_to(photo_categories_url) }
      format.xml  { head :ok }
    end
  end
end
