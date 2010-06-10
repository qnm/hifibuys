class ItemsController < ApplicationController

  before_filter :require_login, :except => [:search, :home, :show]

  # GET /home
  def home
    @manufacturers = Item.tag_counts_on(:manufacturers)
    @types = Item.tag_counts_on(:types)

    respond_to do |format|
      format.html # home.html.erb
    end
  end


  # GET /items
  # GET /items.xml
  def index
    @items = Item.paginate(:all,
                            :page => params[:page], 
                            :per_page => 10, 
                            :order => 'created_at DESC' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/search/:term
  def search
    @items = Item.paginate(:all,
                            :conditions => ["name LIKE ? ", '%' + params['term'].to_s + '%' ],
                            :page => params[:page], 
                            :per_page => 10, 
                            :order => 'created_at DESC' )

    respond_to do |format|
      format.html # search.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  # TODO  we might want to simple throw a 302 header at this point
  # TODO  and not show the item info until we have something better to show
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html { redirect_to @item.url }
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
end
