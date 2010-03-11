class UgItemsController < ApplicationController

  before_filter :require_login

  # GET /ug_items
  # GET /ug_items.xml
  def index
    @ug_items = UgItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ug_items }
    end
  end

  # GET /ug_items/1
  # GET /ug_items/1.xml
  def show
    @ug_item = UgItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ug_item }
    end
  end

  # GET /ug_items/new
  # GET /ug_items/new.xml
  def new
    @ug_item = UgItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ug_item }
    end
  end

  # GET /ug_items/1/edit
  def edit
    @ug_item = UgItem.find(params[:id])
  end

  # POST /ug_items
  # POST /ug_items.xml
  def create
    @ug_item = UgItem.new(params[:ug_item])

    respond_to do |format|
      if @ug_item.save
        flash[:notice] = 'UgItem was successfully created.'
        format.html { redirect_to(@ug_item) }
        format.xml  { render :xml => @ug_item, :status => :created, :location => @ug_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ug_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ug_items/1
  # PUT /ug_items/1.xml
  def update
    @ug_item = UgItem.find(params[:id])

    respond_to do |format|
      if @ug_item.update_attributes(params[:ug_item])
        flash[:notice] = 'UgItem was successfully updated.'
        format.html { redirect_to(@ug_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ug_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ug_items/1
  # DELETE /ug_items/1.xml
  def destroy
    @ug_item = UgItem.find(params[:id])
    @ug_item.destroy

    respond_to do |format|
      format.html { redirect_to(ug_items_url) }
      format.xml  { head :ok }
    end
  end
end
