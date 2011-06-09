class ItemsController < ApplicationController
  caches_action   :home
  cache_sweeper   :item_sweeper
  autocomplete    :item, :name, :full => true

  # GET /home
  def home
    ["manufacturers", "types"].each do |type|
      instance_variable_set("@#{type}", Item.tag_counts_on(type.to_sym))
    end

    @search = Item.search(params[:search])

    response.headers['Cache-Control'] = 'public, max-age=600'
    respond_to do |format|
      format.html # home.html.erb
    end
  end


  # GET /items
  # GET /items.xml
  def index
    @search = Item.search(params[:search])
    @items = @search.all.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC' )

    respond_to do |format|
      format.xml # GCS feed
      format.rss # Add this line so we can respond in RSS format.
      format.html # index.html.haml
    end
  end

  # GET /items
  # GET /items.xml
  def feed
    @items = Item.find(:all).reject { |item| item.name.nil? }
    response.headers['Cache-Control'] = 'public, max-age=600'
    render 'items/feed', :layout => false, :content_type => 'application/xml'
  end


  # GET /items/search/:term
  def search
    @search = Item.search(params[:search])
    @items = @search.all.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC' )

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
      format.html { 
        redirect_to @item.url unless @item.url.blank?
        render :html => @item if @item.url.blank?
      }
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
    @item.seller = current_user
    @item.submitter = current_user

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        flash[:analytics] = "_gaq.push(['_trackPageview', '/items/sell']);"
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
