class ItemsController < ApplicationController

  # GET /items
  def index
  end

  # GET /items/search/:term
  def search
    @items = Item.paginate( :all, 
                            :conditions => ["MATCH (name, description, shop_state, shop_suburb) AGAINST (? IN BOOLEAN MODE)", '+' + params[:term] ],
                            :page => params[:page], 
                            :per_page => 10, 
                            :order => 'created_at DESC' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

end
